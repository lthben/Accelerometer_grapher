import processing.serial.*;

Serial my_port;

//USER DEFINED SETTINGS
String PORTNAME; //define port name in settings.txt file. Follow the name seen in the Arduino IDE under ports.
int SAMPLESIZE; //define sample size in settings.txt file. Must be a factor of 400.

float[][] vals;
int array_index;
float max_xpos, max_xneg, max_ypos, max_yneg;
float raw_xpos, raw_ypos;
String in_string;
boolean is_done;

void setup()
{
        size(800, 400);
        String textlines[] = loadStrings("settings.txt");

        //printArray(Serial.list());
        //print("port name: "); 
        //println(textlines[0]);
        PORTNAME = textlines[0];
        my_port = new Serial(this, textlines[0], 9600);

        SAMPLESIZE = int(textlines[1]);
        //println("Sample size: " + SAMPLESIZE);
        vals = new float[SAMPLESIZE][2];

        my_port.clear();
        //my_port.bufferUntil('\n');
        
}

void draw() 
{
        background(0);

        draw_graph_outlines();

        update_graphs();

        show_extreme_values();
        
        check_if_done();

        fill(255);
        //text(mouseX + "," + mouseY, mouseX, mouseY);
        
        button_update();
        
        println(array_index);
}

void serialEvent(Serial my_port) 
{
        if (!is_done) 
        {
                if (my_port.available() > 0) in_string = my_port.readStringUntil('\n');

                if (in_string != null) {

                        in_string = trim(in_string);
                        //println("in_string: " + in_string);

                        String[] numbers_string = split(in_string, ',');

                        try 
                        {
                                raw_xpos = float(numbers_string[0]);
                                raw_ypos = float(numbers_string[1]); 

                                record_data();

                                array_index = (array_index+1)%(SAMPLESIZE + 1); //update the array index
                        }                
                        catch (Exception e)
                        {
                                e.printStackTrace();
                        }
                }
        }
}

void record_data() 
{
        if (!Float.isNaN(raw_xpos) && !Float.isNaN(raw_ypos))
        {
                vals[array_index][0] = -raw_xpos;  //translating to the y-axis, so must invert as well  
                vals[array_index][1] = -raw_ypos;  //invert the y-axis from Cartesian to computer 

                update_extreme_values();

                //println("array index: " + array_index);

                //if (array_index == 0) 
                //{
                //        println("zero index: " + vals[array_index][0] + "    " + vals[array_index][1]);
                //}
        }
}

void update_extreme_values() 
{
        if (raw_xpos >= 0 && raw_xpos > max_xpos) max_xpos = raw_xpos;
        if (raw_xpos < 0 && raw_xpos < max_xneg) max_xneg = raw_xpos;
        if (raw_ypos >= 0 && raw_ypos > max_ypos) max_ypos = raw_ypos;
        if (raw_ypos < 0 && raw_ypos < max_yneg) max_yneg = raw_ypos;
        //println(max_xpos + " " + max_xneg + " " + max_ypos + " " + max_yneg);
}

void show_extreme_values() 
{
        textAlign(LEFT);
        fill(117, 158, 242);
        text("max_xpos: " + max_xpos, 650, 340); 
        text("max_xneg: " + max_xneg, 520, 340);
        fill(240, 242, 117);
        text("max_ypos: " + max_ypos, 650, 370);
        text("max_yneg: " + max_yneg, 520, 370);

        fill(125);
        text("xpos: " + raw_xpos, 525, 45);
        text("ypos: " + raw_ypos, 620, 45);
        //text("array_index: " + array_index, 525, 50);
}

void check_if_done() {
         if (array_index == SAMPLESIZE) is_done = true;
}