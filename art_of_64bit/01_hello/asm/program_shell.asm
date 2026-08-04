;; ".code" tells MASM the following statements go int memory reserve for
;;  machine instructions
  .code

;; Here is the "main" function (assumes this is a stand alone prog w/ is own
;; main func).
main PROC
  ;; whatever here
  ret                           ; returns to caller
main ENDP

;; Mark end of src fils
  END
  
