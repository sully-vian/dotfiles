;extends

(
 (shell_command 
   (shell_fragment) @injection.content)
 (#set! injection.language "bash")
 (#set! injection.combined)
)
