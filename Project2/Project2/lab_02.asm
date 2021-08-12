Title Address calculations
INCLUDE Irvine32.inc
ROW=2
COLUMN=3
.data
string BYTE "The value of the element a[3,1] is:",0
array DWORD 01,02,03,04
      ROWSIZE=$-array
      DWORD 05,06,07,08
      DWORD 09,10,11,12
      DWORD 13,14,15,16
.code
PrintElement PROC
pushad ;pushes general purpose registers in stack
mov edx, OFFSET string
call WriteString

;Direct Addressing 1
;mov esi,ROWSIZE ;esi=row (size in bytes (4*4=16))
;shl esi,1 ;esi=esi*(2^1)=32 (size of 2 rows) 
;mov edi,1 ;edi=row's element pointer
;add esi,16 ;esi=8+16=24 (number of 4 DWORD elements)
;mov eax,[array + esi+ edi*TYPE array] ;eax=array[3,1]=14 ---> 0000000E

;Direct Addressing 2
;mov esi,4 ;esi=4 (number of elements per row)
;shl esi,1 ;esi=esi*(2^1)=8 (number of elements for 2 rows )
;add esi,5 ;esi=8+5=13 (number of elements for 4 rows + 1 columns)
;mov eax, [array + esi*TYPE array] ;eax=array[3,1]=14 ---> 0000000E

;Direct Addressing 3
;mov esi, DWORD PTR[array+3*ROWSIZE+1*TYPE array]
;mov eax, esi

;Indirect Addressing
mov esi,4 ;esi=4 (number of elements per row)
shl esi,1 ;esi=esi*(2^1)=8 (number of elements for 2 rows )
add esi,5 ;esi=8+5=13 (number of elements for 4 rows + 1 columns)
shl esi,2 ;esi=esi*(2^2) (total bytes for 4 rows and 1 column)
add esi, OFFSET array ;esi=offset(array[3,1])
mov eax,[esi] ;eax=array[3,1]=14 ---> 0000000E

call DumpRegs
popad ;reads general purpose registers from stack in reverse order
ret
PrintElement ENDP
main PROC
call PrintElement
;call PrintElement
exit
main ENDP
END main