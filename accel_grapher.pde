import processing.serial.*;

Serial my_port;

//USER DEFINED SETTINGS
// define port name in settings.txt file
int SAMPLESIZE = 50; 

int COMMA = 44; //ascii values
int CR = 13;

float[][] vals;
int array_index;

String in_string;

void setup()
{
        size(80, 60);
        String textlines[] = loadStrings("settings.txt");

        printArray(Serial.list());
        print("port name: "); 
        println(textlines[0]);
        my_port = new Serial(this, textlines[0], 9600);

        vals = new float[SAMPLESIZE][2];

        in_string = my_port.readStringUntil(CR);
}



void loop() 
{
}

void serialEvent() 
{
        in_string = my_port.readString();

        if (in_string != null) {
                in_string = trim(in_string);
                println(in_string);
        }
}