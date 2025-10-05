import asyncio
import aiohttp
import time
import signal
import sys
from typing import Optional


class RequestSender:
    """
    Sends HTTP GET requests to a target URL with controlled RPS and concurrency.
    """

    def __init__(self, target: str, rps: int, concurrency: int, report_interval: int = 5):
        self.target = target
        self.rps = rps
        self.concurrency = concurrency
        self.report_interval = report_interval
        self.total_requests = 0
        self._stop_event = asyncio.Event()
        self._lock = asyncio.Lock()
        self._rate_limiter = asyncio.Semaphore(0)

    def stop(self) -> None:
        """
        Signal the tasks to stop gracefully.
        """
        print("\nStopping tasks gracefully...")
        self._stop_event.set()

    async def rate_limiter_filler(self) -> None:
        """
        Periodically add tokens to the rate limiter based on the target RPS.
        """
        interval = 1 / self.rps
        try:
            while not self._stop_event.is_set():
                self._rate_limiter.release()
                await asyncio.sleep(interval)
        except asyncio.CancelledError:
            pass

    async def send_request(self, session: aiohttp.ClientSession, task_id: int) -> None:
        """
        Task that sends HTTP GET requests, respecting the rate limiter.
        """
        last_print_time = time.time()
        while not self._stop_event.is_set():
            await self._rate_limiter.acquire()
            try:
                start = time.perf_counter()
                async with session.get(self.target) as resp:
                    duration = time.perf_counter() - start
                    async with self._lock:
                        self.total_requests += 1
                    now = time.time()
                    if now - last_print_time > 1:
                        print(f"[Task {task_id}] Status: {resp.status} Time: {duration:.3f}s | Total requests: {self.total_requests}")
                        last_print_time = now
            except Exception as e:
                print(f"[Task {task_id}] Error: {e}")

    async def progress_reporter(self) -> None:
        """
        Periodically report the total number of requests sent.
        """
        prev_count = 0
        while not self._stop_event.is_set():
            await asyncio.sleep(self.report_interval)
            async with self._lock:
                sent = self.total_requests - prev_count
                prev_count = self.total_requests
            print(f"[Stats] Sent {sent} requests in last {self.report_interval} seconds. Total sent: {self.total_requests}")

    async def run(self) -> None:
        """
        Main runner: sets up tasks and handles graceful shutdown.
        """
        connector = aiohttp.TCPConnector(limit=self.concurrency)
        async with aiohttp.ClientSession(connector=connector) as session:
            print(f"\nStarting {self.concurrency} tasks to achieve approximately {self.rps} requests per second.")
            print("Press Ctrl+C to stop.\n")

            tasks = [asyncio.create_task(self.send_request(session, i)) for i in range(1, self.concurrency + 1)]
            reporter = asyncio.create_task(self.progress_reporter())
            rate_filler = asyncio.create_task(self.rate_limiter_filler())

            await self._stop_event.wait()

            for task in tasks:
                task.cancel()
            reporter.cancel()
            rate_filler.cancel()

            await asyncio.gather(*tasks, return_exceptions=True)
            await asyncio.gather(reporter, rate_filler, return_exceptions=True)

        print("All tasks stopped.")


def main() -> None:
    """
    Entry point with interactive user input.
    """
    target_url = input("Enter the target URL (must start with http:// or https://): ").strip()
    if not target_url.startswith(("http://", "https://")):
        print("Error: Target URL must start with http:// or https://")
        sys.exit(1)

    try:
        rps = int(input("Enter target Requests Per Second (RPS): ").strip())
        if rps <= 0:
            raise ValueError
    except ValueError:
        print("Error: RPS must be a positive integer")
        sys.exit(1)

    try:
        concurrency = int(input("Enter number of concurrent tasks (default 1000): ").strip() or 1000)
        if concurrency <= 0:
            raise ValueError
    except ValueError:
        print("Invalid concurrency value. Using default 1000.")
        concurrency = 1000

    sender = RequestSender(
        target=target_url,
        rps=rps,
        concurrency=concurrency,
        report_interval=5
    )

    loop = asyncio.get_event_loop()

    def shutdown_handler():
        sender.stop()

    try:
        for sig in (signal.SIGINT, signal.SIGTERM):
            loop.add_signal_handler(sig, shutdown_handler)
    except NotImplementedError:
        # Fallback for Windows
        print("Signal handling may be limited on this platform. Use Ctrl+C to stop.")

    try:
        loop.run_until_complete(sender.run())
    except KeyboardInterrupt:
        sender.stop()
        loop.run_until_complete(sender.run())
    finally:
        loop.close()


if __name__ == "__main__":
    main()
