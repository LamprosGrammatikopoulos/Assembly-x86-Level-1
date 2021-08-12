Title Address calculations
INCLUDE Irvine32.inc
ROW=2
COLUMN=3
.data
array BYTE 01,02,03,04
ROWSIZE=$-array
BYTE 05,06,07,08
BYTE 09,10,11,12
BYTE 13,14,15,16
.code
main PROC
mov eax,ROW
Shl eax,2
add eax,OFFSET array
add eax,COLUMN
mov ebx,[eax]
exit
main ENDP
END main

