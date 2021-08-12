TITLE AddThreeNumbers
INCLUDE Irvine32.inc

.data
a DWORD 5
sum DWORD 0
message BYTE "Sum is :",0

.code

; main procedure is the callee
addThreeNumbers PROC
; prologue
push ebp               ;caller
mov ebp,esp            ;create space (base of stack frame)
sub esp,40
pushad                 ;callee

; functional procedure code
mov eax, [ebp+8]       ;add 5 (first argument) 
add eax, [ebp+12]      ;add 6 (second argument)
add eax, [ebp+16]      ;add 10 (third argument)

mov esi,[EBP+20]       ;transfers the sum to a local variable in stack
mov [esi],eax

mov [ebp-4], eax

;ebp-40
;lea edi,[ebp-40]       ;contains the address of a[0] (load effective address) (returns the effective address of one indirect operand) (instead of making indirect reference to (memory) the content of the new offset, transfers the value itself)
;add eax,[edi]
;l1:
; add edi,4
;loop l1                ;loops through all elements of array a[i] until is finds the [EBP-4] address in stack
           
;epilogue
popad                  ;the function                                                                                                           (callee)
mov esp,ebp            ;is destroyed                                                                                                           (callee)
pop ebp                ;in reverse order (moves the value at the top of the stack and increaments ESP) (restores base pointer)                 (callee)

ret 16                 ;STDCALL convention (clears the stack and it's NOT like the return in main in c language)                               (callee)

addThreeNumbers ENDP

; main procedure is the caller
main PROC

; int addThreeNumbers (int a,int b,int c,int *sum)
; int a[10]
push OFFSET sum        ;Pass parameter by-reference
push a		           ;Pass parameter by-value (sends the value to the function) (decrements ESP and moves the value at the top of the stack)
push 6		           ;Pass parameter by-value (sends the value to the function) (decrements ESP and moves the value at the top of the stack)
push 10		           ;Pass parameter by-value (sends the value to the function) (decrements ESP and moves the value at the top of the stack)
call addThreeNumbers   ;return address is stored during the call instruction

mov edx,OFFSET message
call WriteString
mov eax,sum
call WriteInt

exit
main ENDP
END main