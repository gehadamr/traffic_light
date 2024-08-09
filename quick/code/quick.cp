#line 1 "C:/Users/asus/Documents/quick/code/quick.c"







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
 trisd = 0;
 trisc = 0;
 trisb = 3;
 portd = 0;
 portc = 0;
 portb = 0;
 gie_bit = 1;
 inte_bit = 1;
 intedg_bit = 1;
}


void manual_() {

 if (manual == 1) {
 if (count == 1) {
  portc.b0  = 1;
  portc.b1  = 0;
  portc.b2  = 0;
 ind2=0;
  portc.b3  = 0;
 for ( k = 3; k > 0; k--) {

 if (ind1 >= 1) {
  portd =segment[0];
 continue;
 }
  portc.b4 =1;
  portd  = segment[k];
 delay_ms(50);
 }
 ind1 = 1;
  portc.b3  = 0;
  portc.b4  = 0;
  portc.b5  = 1;
 }
 else if (count == 2) {
 ind1=0;
  portc.b0  = 0;
  portc.b5  = 0;
  portc.b3  = 1;
 count=0;
 for ( k = 3; k > 0; k--) {
 if (ind2 >= 1) {
  portd =segment[0];
 continue;
 }
  portc.b1 =1;
  portd  = segment[k];
 delay_ms(50);
 }
 ind2 = 1;
  portc.b2  = 1;
  portc.b4  = 0;
  portc.b1  =0;
 }
 }
}

 void automatic() {
 if (manual == 0) {
 if (portc == 0 ||  portc.b3  == 1) {
 for (i = 23; i > 0; i--) {
  portc.b0  = 0;
 if(i <= 3)
  portc.b1  = 1;
 else
  portc.b1  = 0;
 if(i > 3)
  portc.b2  = 1;
 else
  portc.b2 =0;
  portc.b3  = 1;
  portc.b4  = 0;
  portc.b5  = 0;
  portd  = segment[i];
 delay_ms(100);
 }
 if (manual != 1)  portc.b3  = 0;
 } else {
 for (i = 15; i > 0; i--) {
  portc.b0  = 1;
  portc.b1  = 0;
  portc.b2  = 0;
  portc.b3  = 0;
 if(i <= 3)
  portc.b4  =1;
 else
  portc.b4 =0;
 if(i > 3)
  portc.b5  =1;
 else
  portc.b5 =0;
  portd  = segment[i];
 delay_ms(100);
 }
 if (manual == 0)  portc.b0  = 1;
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
