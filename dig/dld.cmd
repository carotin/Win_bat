@echo off&cd /d "%~dp0"&SETLOCAL&set "_fdp=%~dp0"
rem ʹ�ö��DNS��ѯָ������/�б����Ϊ Unbound �� local-data: ��ʽ
set _dns=202.96.128.86 208.67.220.220 202.96.134.133 202.96.128.166 208.67.222.222
set _otf=DLD
if "%~d1" neq "" (
    rem echo ��⵽�����������������&echo,%cmdcmdline%
    set "str=%cmdcmdline:"=%"
    SETLOCAL ENABLEDELAYEDEXPANSION&set _slf=1
    set "_inp=%~1"&call :_fle
    if "!_isf!"=="1" (
	for %%d in (%_dns%) do call :_dgd %~1 %%d
	echo,&echo,  --OK	%~1&ENDLOCAL&goto :eof
    )
    set "str=!str:%~f0 =!"
    set "str=!str: %~d1=" "%~d1!"
    for %%n in ("!str!") do (
	if defined _slf ENDLOCAL
	if exist "%%~fn\" (cls&echo "%%~fn"��Ŀ¼��������Ч���ļ���������&echo,) else if exist "%%~fn" (
	    title "%~f0" "%%~fn"&set _id=1&set "_otn=%%~nn"
	    for /f "eol=# usebackq" %%p in ("%%~fn") do (set "_inp=%%p"&call :_fle
		SETLOCAL ENABLEDELAYEDEXPANSION&if "!_isf!"=="1" (
		    for %%d in (%_dns%) do call :_dg %%p %%d
		    echo,!_id!		#>>%_otf%_!_otn!.conf
		    echo,!_id!	OK	%%p&ENDLOCAL&set/a_id+=1
		) else ENDLOCAL
	    )
	)
    )
)

echo,&echo ��ɣ���������˳���&pause>nul
goto :eof

:_fle	rem ����������Ч����֤���ж��Ƿ�ΪIP��������ΪIPʱ _isf=0��Ϊ����ʱ _isf=1�����򲻶��� _isf
    set _isf=&SETLOCAL ENABLEDELAYEDEXPANSION&rem echo ���룺!_inp! �Ƚ�_isf��գ�����ʹ���ϴε�_isf��Ҳ������ѭ���д���
    if defined _inp (rem �ж��Ƿ��������Լ���Ч�ַ�
	set "_in1=!_inp:"=#!"
	set "_in2=!_inp:"=@!"
	if "!_in1!" neq "!_in2!" ENDLOCAL&goto :eof	rem !_inp!�������ţ����ܼ����ж�
	for /f "tokens=*delims=0123456789.abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ eol=" %%a in ("!_inp!")do if "%%a" neq "" ENDLOCAL&goto :eof
	set _in1=!_inp:..=!
	if "!_in1!" neq "!_inp!" ENDLOCAL&goto :eof	rem �ж�����������
	set _b=!_inp:~0,1!&set _e=!_inp:~-1!
	if "!_b!"=="." ENDLOCAL&goto :eof	rem ���ж����㡣����
rem	if "!_e!"=="." set _psf=1&rem echo β�ж����㡣�����ݲ���������������
	set _in2=!_inp:.=;!
	if "!_in2!"=="!_inp!" ENDLOCAL&goto :eof	rem ��������㡣����

	set/a _ii=_it=0
	for %%c in (!_in2!) do (
	    set/a _ii+=1&set _!_ii!=%%c
	    if %%c leq 255 if %%c geq 0 set/a _it+=1
	    call set _bb=%%_!_ii!:~0,1%%&call set _ee=%%_!_ii!:~-1%%
	    if !_bb!==- ENDLOCAL&goto :eof	rem �ж���ĺ���-��
	    if !_ee!==- ENDLOCAL&goto :eof	rem �ж���ĺ���-��
	)
	for /f "tokens=*delims=0123456789. eol=" %%a in ("!_inp!") do if "%%a"=="" (if !_e! neq . if !_it! equ 4 if !_ii! equ 4 set _isf=0) else (
	rem echo ����IP���ж��Ƿ�Ϊ����
	    for %%c in (!_ii!) do set _tld=!_%%c!
	    for /f "tokens=*delims=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%a in ("!_tld!") do if "%%a"=="" (
		for %%z in (com net org info biz name pro edu gov int club asia) do if !_tld!==%%z set _isf=1&rem echo �ǳ�����ͨ��������׺
		if !_tld!==!_tld:~-2! if !_tld! neq !_tld:~-1! set _isf=1&rem echo ��׺��������ĸ��������Ϊ������
	    )
	)
	if defined _isf (for %%a in (!_isf!) do ENDLOCAL&set _isf=%%a)&goto :eof	rem ����Ч��IP������
    )
ENDLOCAL&goto :eof

:_dg
  for /f "tokens=4-5" %%d in ('dig @%2 +noall +answer %1^|findstr "\<CNAME\> \<A\>"') do (
  	if "%%d"=="A" (
  		if not defined _d set _d=_&echo,!_id!	    local-zone: "%1" static	#!_c!	#%2>>%_otf%_%_otn%.conf
  		if not defined %%e set %%e=_&echo,!_id!		 local-data: "%1 300 IN A %%e"	#%2>>%_otf%_%_otn%.conf
  	) else set _c=!_c! %%e
  )
  rem echo,!_id!		#>>%_otf%_%_otn%.conf
  goto :eof

:_dgd
for /f "tokens=1-5" %%a in ('dig @%2 +noall +answer %1^|findstr "\<CNAME\> \<A\>"') do (
	if "%%d"=="A" (
		if not defined _d set _d=_&echo,    local-zone: "!_dn!" static	#!_c!
		if not defined %%e set %%e=_&echo,	local-data: "!_dn! %%b %%c %%d %%e"
	) else set _c=!_c! %%e&if not defined _dn set _dn=%%a
)
goto :eof

