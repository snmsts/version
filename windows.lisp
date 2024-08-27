(defpackage :version.windows
  (:use :cl)
  (:export :get-version-ex))
(in-package :version.windows)
            
(cffi:defctype DWORD :uint32)
(cffi:defctype WORD :uint16)
(cffi:defctype BYTE :uint8)
(cffi:defctype BOOL :uchar)

(cffi:defcstruct OSVERSIONINFOEXA
  (dwOSVersionInfoSize DWORD)
  (dwMajorVersion DWORD)
  (dwMinorVersion DWORD)
  (dwBuildNumber DWORD)
  (dwPlatformId DWORD)
  (szCSDVersion  :CHAR :count 128)
  (wServicePackMajor  WORD)
  (wServicePackMinor  WORD)
  (wSuiteMask  WORD)
  (wProductType  BYTE)
  (wReserved  BYTE))

(cffi:defcfun (memset "memset") :pointer
  (dest :pointer)
  (fill :int)
  (size :uint))

(cffi:defcfun (GetVersionEx "GetVersionExA" :convention :stdcall) BOOL
  (lpVersionInformation :pointer))

(defun get-version-ex ()
  (cffi:with-foreign-object (osvi '(:struct OSVERSIONINFOEXA))
    (memset osvi 0 (cffi:foreign-type-size '(:struct OSVERSIONINFOEXA)))
    (cffi:with-foreign-slots ((dwOSVersionInfoSize
                               dwMajorVersion
                               dwMinorVersion
                               dwBuildNumber
                               dwPlatformId
                               szCSDVersion)
                              osvi (:struct OSVERSIONINFOEXA))
      (setf dwOSVersionInfoSize (cffi:foreign-type-size '(:struct OSVERSIONINFOEXA)))
      (unless (zerop (GetVersionEx osvi))
        (values dwMajorVersion
                dwMinorVersion
                dwBuildNumber
                dwPlatformId
                (cffi:foreign-string-to-lisp szCSDVersion))))))
