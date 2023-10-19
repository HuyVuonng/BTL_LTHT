#include <iostream.h>
#include <conio.h>

extern int MOVEF();
extern int TimMin();
extern int DRAW();

void main()
{
   int chon;
    clrscr();
cout<<"\n BTL lap trinh he thong";
cout<<"\n 1.Ve duong thang";
cout<<"\n 2.Tim min";
cout<<"\n 3.Chuyen file";
cout<<"\n 0.Thoat chuong trinh";
cout<<"\n Hay nhap lua chon cua ban:";
cin>> chon;

while(chon!=0 && chon!=1 && chon!=2 && chon!=3){

		 cout<<"\n Nhap khong hop le!";
    	cout<<"\n Hay nhap lai:";
    	cin>> chon;
};
switch(chon){
	case 1:
    	DRAW();
    	break;
	case 2:
    	TimMin();
    	break;
	case 3:
    	MOVEF();
    	break;
	default: break;
	}
}
