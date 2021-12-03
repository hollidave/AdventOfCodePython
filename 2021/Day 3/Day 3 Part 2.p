 
DEFINE VARIABLE nWinner          AS DECIMAL NO-UNDO. 
DEFINE VARIABLE iMost           AS integer NO-UNDO EXTENT 12. 
DEFINE VARIABLE iLeast          AS integer NO-UNDO EXTENT 12. 
DEFINE VARIABLE cAscii           AS CHAR NO-UNDO.  
DEFINE VARIABLE iTotal           AS INTEGER NO-UNDO. 
DEFINE VARIABLE iTotal2           AS INTEGER NO-UNDO. 
DEFINE VARIABLE iCount           AS INTEGER NO-UNDO.  
DEFINE VARIABLE iCount2           AS INTEGER NO-UNDO.  
DEFINE VARIABLE iRow           AS INTEGER NO-UNDO.   
DEFINE VARIABLE iAnswer           AS INTEGER NO-UNDO INITIAL 1.  

DEFINE TEMP-TABLE ttBits
    FIELD iRow   AS INT
    FIELD cValue AS CHAR
    FIELD lMost  AS LOG
    FIELD iValue AS INT EXTENT 12
    FIELD nNumber AS DEC 
INDEX idxBits iRow. 

DEF STREAM stFileLoad.
    
INPUT STREAM stFileLoad FROM VALUE("H:\Advent\Day3.txt").  

REPEAT:       
    IMPORT STREAM stFileLoad  cAscii. 
    
    ASSIGN iRow = iRow + 1.
    IF cAscii <> "" THEN DO:
        RUN prCreateRow(cAscii, TRUE).
        RUN prCreateRow(cAscii, FALSE).
    END.
    iTotal = iTotal + 1.
END.

INPUT STREAM stFileLoad CLOSE. 

RUN prGetNumber(TRUE).
RUN prGetNumber(FALSE).

FOR EACH ttBits: 
    ASSIGN iAnswer = iAnswer * ttBits.nNumber.
END.
    MESSAGE iAnswer
        VIEW-AS ALERT-BOX INFO BUTTONS OK.

PROCEDURE prGetNumber:  
    DEFINE INPUT PARAMETER ilMost     AS LOGICAL NO-UNDO.
    
    ASSIGN iTotal2 = iTotal.

    COUNTLOOP:
    DO iCount = 1 TO 12:   
        RUN prCalcWinner(ilMost, iCount, OUTPUT nWinner). 
 
        nWinner = nWinner / iTotal2.  
        IF nWinner < 0.5 THEN 
            ASSIGN iMost[iCount] = 0
                   iLeast[iCount] = 1.
        ELSE IF nWinner >= 0.5  THEN
            ASSIGN iMost[iCount] = 1
                   iLeast[iCount] = 0.  
        FOR EACH ttBits WHERE ttBits.lMost = ilMost: 

            IF (ttBits.iValue[iCount] <> iMost[iCount] AND ilMost) OR
               (ttBits.iValue[iCount] <> iLeast[iCount] AND ilMost = FALSE) THEN DO: 
                DELETE ttBits.
                iTotal2 = iTotal2 - 1. 
            END.
        END.
    
        FIND ttBits WHERE ttBits.lMost = ilMost NO-ERROR.
        IF AVAILABLE ttBits THEN
            LEAVE COUNTLOOP. 
    
    END. 

END PROCEDURE.


PROCEDURE prCalcWinner:

    DEFINE INPUT PARAMETER ilMost  AS LOGICAL NO-UNDO.
    DEFINE INPUT PARAMETER iiWinner     AS INTEGER.
    DEFINE OUTPUT PARAMETER onWinner     AS DECIMAL.
    
    FOR EACH ttBits WHERE lMost = ilMost:
        onWinner = onWinner + ttBits.iValue[iiWinner].
    END. 

END PROCEDURE.

PROCEDURE prCreateRow:

    DEFINE INPUT PARAMETER icAscii  AS CHAR NO-UNDO.
    DEFINE INPUT PARAMETER ilMost  AS LOGICAL NO-UNDO.

    CREATE ttBits.
    ASSIGN ttBits.cValue = icAscii
           ttBits.iRow = iRow
           ttBits.lMost = ilMost.

    DO iCount = 1 TO 12:   
        iValue[iCount] = INTEGER(SUBSTRING(icAscii, iCount, 1)).
        
        ttBits.nNumber = ttBits.nNumber + (iValue[iCount] * EXP(2,12 - iCount)). 
    END.
END PROCEDURE.
