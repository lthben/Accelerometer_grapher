boolean mouse_over = false;
color button_curr_color, button_default_color = color(255), 
        button_highlight_color = color(100), button_activated_color = color(255, 0, 0); 

PrintWriter pw;
                
boolean over_rect(int x, int y, int width, int height) 
{
        if (mouseX >= x && mouseX <= x+width && 
                mouseY >= y && mouseY <= y+height) 
        {
                return true;
        } else 
        {
                return false;
        }
}

void write_log_file() 
{        
         if (pw != null) 
         {
                 pw = null;
         }
         pw = createWriter("logged_data.txt");
                  
         for (int i=0; i<array_index; i++)
         {
                  pw.println(vals[i][0] + " " + vals[i][1]);    
         }
         
         pw.flush();
         pw.close();        
}

void button_update() 
{       
        strokeWeight(1);
        stroke(100);
        fill(button_curr_color);
        rect(710, 30, 40, 20);

        mouse_over = over_rect(710, 30, 40, 20);

        if (mouse_over)
        {
                button_curr_color = button_highlight_color;
        } else 
        {
                button_curr_color = button_default_color;
        }

        fill(0);
        text("log", 720, 45);
}

void mousePressed() 
{
        if (mouse_over) 
        {
                button_curr_color = button_activated_color;
                
                write_log_file();
        }
}
        