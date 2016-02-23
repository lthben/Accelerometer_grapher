void draw_graph_outlines() 
{
        //lines
        strokeWeight(1);
        stroke(255, 255, 255, 50);

        //text
        fill(100);
        textAlign(CENTER, CENTER);

        //time graph 
        pushMatrix();
        translate(40, height/2);
        line(0, -180, 0, 180); //axes
        line(0, 0, 400, 0);

        for (int i=0; i<SAMPLESIZE; i++) //tick markers
        {
                line( (i*1.0/SAMPLESIZE)*400, 2, (i*1.0/SAMPLESIZE)*400, -2);
        }
        popMatrix();

        text("90", 40, 10);
        text("-90", 40, 390);       
        text("t", 460, 200);

        //burst graph 
        pushMatrix();
        translate(625, height/2);
        line(-90, 0, 90, 0);
        line(0, 90, 0, -90);
        popMatrix();

        text("90", 730, 200);
        text("-90", 520, 200);
        text("90", 625, 100);
        text("-90", 623, 300);
}

void update_graphs() 
{
        //time graph
        pushMatrix();
        translate(40, height/2);

        //moving ticker line
        stroke(255, 255, 255, 25);
        line( ( (array_index)*1.0 / (SAMPLESIZE-1) )*400, -180, ( (array_index)*1.0 / (SAMPLESIZE-1) )*400, 180);

        //data points
        for (int i=0; i<SAMPLESIZE; i++) 
        {
                noFill(); 
                stroke(255);             
                ellipse( ( i*1.0 / (SAMPLESIZE-1) )*400, vals[i][0]*2, 2, 2);    
                ellipse( ( i*1.0 / (SAMPLESIZE-1) )*400, vals[i][1]*2, 2, 2);    


                if (i>0) 
                {
                        stroke(117, 158, 242); //color for the xpos
                        line( (i*1.0 / (SAMPLESIZE-1) )*400, vals[i][0]*2, ((i-1)*1.0 / (SAMPLESIZE-1) )*400, vals[i-1][0]*2 );
                        stroke(240, 242, 117); //color for the ypos
                        line( (i*1.0 / (SAMPLESIZE-1) )*400, vals[i][1]*2, ((i-1)*1.0 / (SAMPLESIZE-1) )*400, vals[i-1][1]*2 );
                }
        }
        popMatrix();

        //burst graph
        pushMatrix();
        translate(625, height/2);

        for (int i=0; i<SAMPLESIZE; i++) 
        {         
                stroke(125);
                strokeWeight(1);
                line(0, 0, -vals[i][0], vals[i][1]); //invert back the xpos values since previously was inverted
        }
        
        stroke(255,0,0); //latest always on top
        strokeWeight(2);
        line(0,0, raw_xpos, -raw_ypos);
        
        popMatrix();
}