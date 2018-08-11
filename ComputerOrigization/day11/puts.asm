DATA SEGMENT
	BUFFER DB 10 DUP(?)
	;定义数据段,放入10个空位置,DPU()相当于malloc(x)，用于写入数据
DATA ENDS

;使用默认堆栈段

CODE SEGMENT
	ASSUME CS:CODE,DS:DATA
	;代码段
	;设置代码段和数据段的段基地址

START:
	MOV AX,DATA 	
	MOV DS,AX

	MOV BX,OFFSET BUFFER
	MOV AH,1
	INT 21H
	CMP AL,' '
	JNZ EXIT

NEXT:
	MOV AH,1
	INT 21H
	CMP AL,' '
	JZ OUT_ALL
	MOV [BX],AL
	INC BX
	JMP NEXT

OUT_ALL:
	MOV DL,13	;回车 结尾
	MOV AH,2
	INT 21H
	MOV DL,10	;换行
	MOV AH,2
	INT 21H		;AH=2 单独显示DL的内容

	MOV BYTE PTR [BX],'$'
	MOV AH,9	
	MOV DX,OFFSET BUFFER
	INT 21H

EXIT:
	MOV AH,4CH
	INT 21H  		
CODE ENDS			
	END START		