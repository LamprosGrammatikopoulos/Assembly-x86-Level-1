TITLE lab_final
Include Irvine32.inc

.data
array WORD 10,20,30,40,50,60,70,80,90,100
arraylength = ($-array)/TYPE array
.code
; ************* MAIN PROCEDURE ******************
main PROC
push ebp
mov ebp,esp
sub esp,8  ; EBP-4 -> mean,   EBP-8 -> variance

; void main(){
; int mean;    EBP-4
;}

;void mean(int *array, int len,int *mean,int elementwidth) ;proto kai proteleftaio orisma einai by reference 
; CALL MEAN 
lea eax, [ebp-4]	;load the variance address to eax
push TYPE WORD
push eax	 ;eax pushes the variance address
push DWORD PTR arraylength
push OFFSET array
call mean

; PRINT MEAN TO THE CONSOLE
mov eax,[ebp-4]
call WriteInt

; void variance(int *array, int len, int *variance, int elementwidth)
;CALL VARIANCE
push eax			;eax pushes the mean value	
push TYPE WORD
lea eax, [ebp-8]	;load the variance address to eax
push eax			;eax pushes the variance address
push DWORD PTR arraylength
push OFFSET array
call variance

; PRINT VARIANCE TO THE CONSOLE
mov eax,[ebp-8]
call WriteInt

mov esp,ebp
pop ebp
exit
main ENDP

; *********** MEAN PROCEDURE *******************
mean PROC
push ebp
mov ebp,esp
pushad

mov ecx, [ebp+12] ; ecx loop iterator
mov esi, [ebp+8]  ; esi holds the element address
mov ebx, 0		  ; ebx holds the sum
mov eax,0
L1:
mov ax, [esi]
add bx, ax
add esi, [ebp+20]
loop L1

mov ax,bx
cwd
div WORD PTR [ebp+12]

mov esi,[ebp+16]
movzx eax,ax
mov [esi], eax

popad
mov esp,ebp
pop ebp
ret 12
mean ENDP

; void variance(int *array, int len, int *variance, int elementwidth, int mean)
;*********************** VARIANCE PROCEDURE ********************
variance PROC
push ebp
mov ebp,esp
pushad


mov esi, [ebp+8]  ; esi holds the element address
mov ecx, [ebp+12] ; ecx loop iterator
mov eax,0		  ; clear eax to avoid garbage in WORD operations
mov ebx,0		  ; ebx holds the sum
L1:

mov ax,WORD PTR [esi]
sub eax,[ebp+24]
imul eax
add ebx,eax
add esi, [ebp+20]
loop L1

mov eax,ebx  ; move the result to eax to implement division
cdq          ;clear edx for divion puproses
div DWORD PTR [ebp+12]

mov esi,[ebp+16]
mov [esi], eax

popad
mov esp,ebp
pop ebp
ret 20
variance ENDP
END main