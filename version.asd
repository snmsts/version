(defsystem version
  :description "GetVersion wrapper"
  :author "Masatoshi SANO <snmsts@gmail.com>"
  :version "0.0.1"
  :license "MIT"
  :defsystem-depends-on (:trivial-features :cffi)
  :depends-on (:trivial-features :cffi)
  :components
  ((:file "windows" :if-feature :os-windows)
   
   ))

          
  