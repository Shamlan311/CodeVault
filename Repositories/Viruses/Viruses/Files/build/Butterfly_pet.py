import tkinter as tk
import random
import math
import threading

# Global list to keep track of all butterflies
butterflies = []

def create_new_butterfly():
    """Function to create a new butterfly in its own window"""
    new_butterfly = ButterflyPet()
    # Run it in a separate thread so it doesn't block
    def run_butterfly():
        new_butterfly.root.mainloop()
    
    butterfly_thread = threading.Thread(target=run_butterfly, daemon=True)
    butterfly_thread.start()
    return new_butterfly

class ButterflyPet:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Butterfly Pet")
        self.root.attributes('-topmost', True)  # Keep on top
        self.root.attributes('-toolwindow', True)  # Remove from taskbar
        self.root.overrideredirect(True)  # Remove window decorations
        self.root.configure(bg='white')
        self.root.attributes('-transparentcolor', 'white')  # Make background transparent
        
        # Get screen dimensions
        self.screen_width = self.root.winfo_screenwidth()
        self.screen_height = self.root.winfo_screenheight()
        
        # Butterfly properties - REALISTIC SIZE
        self.x = random.randint(100, self.screen_width - 200)
        self.y = random.randint(100, self.screen_height - 200)
        self.speed = 1
        self.direction_x = random.choice([-1, 1])
        self.direction_y = random.choice([-1, 1])
        self.wing_phase = 0
        
        # More realistic butterfly colors
        wing_colors = [
            ['#FF6B35', '#FF8E53'],  # Orange Monarch
            ['#4A90E2', '#7BB3F0'],  # Blue Morpho
            ['#F39C12', '#F7DC6F'],  # Golden
            ['#8E44AD', '#BB8FCE'],  # Purple
            ['#E74C3C', '#F1948A'],  # Red
            ['#27AE60', '#82E0AA'],  # Green
        ]
        colors = random.choice(wing_colors)
        self.wing_color1 = colors[0]
        self.wing_color2 = colors[1]
        
        # Create butterfly display - REALISTIC SIZE
        self.canvas = tk.Canvas(self.root, width=90, height=70, bg='white', highlightthickness=0)
        self.canvas.pack()
        
        # Bind double-click to spawn new butterfly
        self.canvas.bind('<Double-Button-1>', self.spawn_butterfly)
        self.root.bind('<Double-Button-1>', self.spawn_butterfly)
        
        # Bind right-click to close
        self.canvas.bind('<Button-3>', self.close_app)
        self.root.bind('<Button-3>', self.close_app)
        
        # Position window
        self.root.geometry(f"90x70+{self.x}+{self.y}")
        
        # Add to global list
        butterflies.append(self)
        
        # Start animation
        self.animate()
        
    def draw_butterfly(self):
        self.canvas.delete("all")
        
        # Wing animation (flapping effect) - realistic
        wing_offset = math.sin(self.wing_phase) * 3
        
        # Body - realistic size
        self.canvas.create_oval(42, 25, 48, 45, fill='#2C3E50', outline='#1B2631', width=2)
        
        # Wings - realistic proportions
        # Top wings
        wing_color = self.wing_color1 if self.wing_phase % 2 < 1 else self.wing_color2
        self.canvas.create_oval(20 + wing_offset, 15, 42, 35, fill=wing_color, outline='#34495E', width=2)
        self.canvas.create_oval(48, 15, 70 - wing_offset, 35, fill=wing_color, outline='#34495E', width=2)
        
        # Bottom wings - smaller than top wings (realistic)
        bottom_color = self.wing_color2 if self.wing_phase % 2 < 1 else self.wing_color1
        self.canvas.create_oval(25 + wing_offset//2, 32, 42, 50, fill=bottom_color, outline='#34495E', width=2)
        self.canvas.create_oval(48, 32, 65 - wing_offset//2, 50, fill=bottom_color, outline='#34495E', width=2)
        
        # Wing spots - subtle and realistic
        self.canvas.create_oval(28 + wing_offset//2, 20, 35 + wing_offset//2, 27, fill='#2C3E50', outline='#1B2631')
        self.canvas.create_oval(55 - wing_offset//2, 20, 62 - wing_offset//2, 27, fill='#2C3E50', outline='#1B2631')
        
        # Small wing details
        self.canvas.create_oval(32 + wing_offset//3, 37, 38 + wing_offset//3, 43, fill='#E8DAEF')
        self.canvas.create_oval(52 - wing_offset//3, 37, 58 - wing_offset//3, 43, fill='#E8DAEF')
        
        # Antennae - thin and realistic
        self.canvas.create_line(44, 25, 38, 18, fill='black', width=2)
        self.canvas.create_line(46, 25, 52, 18, fill='black', width=2)
        self.canvas.create_oval(37, 17, 40, 20, fill='black')
        self.canvas.create_oval(50, 17, 53, 20, fill='black')
    
    def move_butterfly(self):
        # More natural movement - butterflies don't move in straight lines
        if random.random() < 0.04:  # 4% chance to change direction (less frequent)
            self.direction_x = random.choice([-1, 1])
        if random.random() < 0.04:
            self.direction_y = random.choice([-1, 1])
        
        # Gentle flutter-like randomness
        random_x = random.randint(-1, 1)
        random_y = random.randint(-1, 1)
        
        # Calculate new position
        new_x = self.x + (self.direction_x * self.speed) + random_x
        new_y = self.y + (self.direction_y * self.speed) + random_y
        
        # Bounce off screen edges
        if new_x <= 0 or new_x >= self.screen_width - 90:
            self.direction_x *= -1
        else:
            self.x = new_x
            
        if new_y <= 0 or new_y >= self.screen_height - 70:
            self.direction_y *= -1
        else:
            self.y = new_y
        
        # Update window position
        self.root.geometry(f"90x70+{self.x}+{self.y}")
    
    def animate(self):
        try:
            self.draw_butterfly()
            self.move_butterfly()
            self.wing_phase += 0.2  # Slower, more gentle wing flapping
            
            # Schedule next frame - slower, more peaceful movement
            self.root.after(50, self.animate)
        except tk.TclError:
            # Window was destroyed, stop animating
            pass
    
    def spawn_butterfly(self, event=None):
        """Spawn a new butterfly when double-clicked"""
        create_new_butterfly()
    
    def close_app(self, event=None):
        """Close this butterfly"""
        # Remove from global list
        if self in butterflies:
            butterflies.remove(self)
        self.root.destroy()
    
    def run(self):
        self.root.mainloop()

if __name__ == "__main__":
    first_butterfly = ButterflyPet()
    first_butterfly.run()
