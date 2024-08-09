#define red1  portc.b0
#define yellow1 portc.b1
#define green1 portc.b2
#define red2 portc.b3
#define yellow2 portc.b4
#define green2 portc.b5
#define display portd
int segment[] = {0x00, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
                 0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9,
                 0xE0, 0xE1, 0xE2, 0xE3};
char i, j;
char manual = 0;
char count=0 ;
char k;
char ind1=0;
char ind2=0;
void interrupt() {
    if (intf_bit) {
        intf_bit = 0;
        if (manual == 0) {
           manual = 1;
        }
        ++count;
    }
    return;
}

void initial() {
    trisd = 0;  // 7 segment
    trisc = 0;  // LEDs
    trisb = 3;  // b0 interrupt, b1 manual, b2 manual automatic
    portd = 0;
    portc = 0;
    portb = 0;
    gie_bit = 1;
    inte_bit = 1;  // Activate enable
    intedg_bit = 1;  // Rising edge
}


void manual_() {

    if (manual == 1) {
        if (count == 1) {
            red1 = 1;
            yellow1 = 0;
            green1 = 0;
            ind2=0;
            red2 = 0;
            for ( k = 3; k > 0; k--) {

                if (ind1 >= 1) {
                display=segment[0];
                    continue;
                }
                yellow2=1;
                display = segment[k];
                delay_ms(50);
            }
            ind1 = 1;
            red2 = 0;
            yellow2 = 0;
            green2 = 1;
        }
        else if (count == 2) {
            ind1=0;
            red1 = 0;
            green2 = 0;
            red2 = 1;
            count=0;
            for ( k = 3; k > 0; k--) {
                if (ind2 >= 1) {
                 display=segment[0];
                    continue;
                }
                yellow1=1;
                display = segment[k];
                delay_ms(50);
            }
             ind2 = 1;
            green1 = 1;
            yellow2 = 0;
            yellow1 =0;
        }
      }
}

    void automatic() {
    if (manual == 0) {
        if (portc == 0 || red2 == 1) {
            for (i = 23; i > 0; i--) {
                red1 = 0;
                if(i <= 3)
                yellow1 = 1;
                else
                yellow1 = 0;
                if(i > 3)
                green1 = 1;
                else
                green1=0;
                red2 = 1;
                yellow2 = 0;
                green2 = 0;
                display = segment[i];
                delay_ms(100);
            }
            if (manual != 1) red2 = 0;
        } else {
            for (i = 15; i > 0; i--) {
                red1 = 1;
                yellow1 = 0;
                green1 = 0;
                red2 = 0;
                if(i <= 3)
                yellow2 =1;
                else
                yellow2=0;
                if(i > 3)
                green2 =1;
                else
                green2=0;
                display = segment[i];
                delay_ms(100);
            }
            if (manual == 0) red1 = 1;
        }
    }
}
void switching (){
if(portb.b1==0&&manual==1)
manual_();
if(portb.b1==1&&manual==0)
automatic();}
void main() {
    initial();
    while (1) {

    switching();
    }
}