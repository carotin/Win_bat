@echo off&cd /d "%~dp0"&SETLOCAL&set "_fdp=%~dp0"
rem ���Ϸ��ļ���������ʱ��Ĭ��Ŀ¼���ǵ�ǰ����������Ŀ¼��%~dp0�������û�����Ŀ¼��%USERPROFILE%
for /f "tokens=2-3delims=. " %%b in ('curl -V 2^>nul^|find/i "ssl"') do set _cv=%%b%%c&goto :next
:next
if defined _cv (if 1%_cv% lss 1749 echo,CURL version is too old, please update!&pause>nul&goto :EOF) else echo,curl.exe does not exist! please download:&echo,https://curl.haxx.se/download.html#Win32&pause>nul&goto :EOF

set/a _dbg=0,_tm=3,_tc=2,_rt=1
rem _tm���������curl�����ĳ�ʱʱ��(curl -m, --max-time <time>����ֵ)��_tc�����ӽ׶εĳ�ʱʱ�䣻_rt����ʱ�����Դ���

set _pmt=���,IP,SNI
set "_c=curl -0 -sm%_tm% --connect-timeout %_tc% --retry %_rt% --connect-to ::!_ipt! --no-keepalive https://"
set "_q=>nul&&set _r=Y||(if !errorlevel! equ 28 (set _r=Timeout) else set _r=No)"
if %_dbg% equ 1 (set "_c=%_c:-s=-sS%") else if %_dbg% gtr 1 set "_c=%_c:-s=-v%"

if "%~d1" neq "" (
rem    echo ��⵽�����������������&echo,%cmdcmdline%
    set "str=%cmdcmdline:"=%"
    SETLOCAL ENABLEDELAYEDEXPANSION&set _slf=1
    set "_ipt=%~1"&call :_fle
    if not defined _psf (
	for %%d in (baidu bing Google) do %_c%%%d.com/%_q%&echo,!_ipt!	!_r!	%%d
	%_c%g.co/favicon.ico%_q%
	echo,!_ipt!	!_r!	g.co&ENDLOCAL&goto :eof
    )
    set "str=!str:%~f0 =!"
    set "str=!str: %~d1=" "%~d1!"
    for %%n in ("!str!") do (
	if defined _slf ENDLOCAL
	if exist "%%~fn\" (cls&echo "%%~fn"��Ŀ¼��������Ч���ļ���������&echo,) else if exist "%%~fn" (
	    title "%~f0" "%%~fn"&set _id=1&set "_otn=%%~nn"
	    for /f "eol=# usebackq" %%p in ("%%~fn") do (set "_ipt=%%p"&call :_fle
		if not defined _psf (SETLOCAL ENABLEDELAYEDEXPANSION&call :_tSNI
		    if !_id! gtr 999 (set "_sp=") else if !_id! gtr 99 (set "_sp= ") else if !_id! gtr 9 (set "_sp=  ") else set "_sp=   "
		    echo,*!_sp!!_id!	!_ipt!	!_r!
		    echo,!_id!,!_ipt!,!_r!>>"!_otn!_!_otf!"&rem �˴���%%���ñ�����Ч
		    for %%c in ("!_otf!")do ENDLOCAL&set "_otf=%%~c"&set/a_id+=1
		)
	    )
	    SETLOCAL ENABLEDELAYEDEXPANSION&(if !_id! gtr 1 echo,&echo -----����ļ���"!_fdp!!_otn!_!_otf!")&ENDLOCAL
	)
    )
) else (
    title "%~f0"
    :_rip
    echo ������ û�������ļ����رճ��򣬻��ߣ�������&echo �٣����루��������IP�ģ��ļ�·����
    echo �ڣ����߽���IP�б��ļ��Ϸŵ��������ڣ��س��Լ�����
    set _inpt=&set /p _inpt=�ۣ����롰y����Сд���ӱ���Hosts��ȡIP��

    if defined _inpt (
	SETLOCAL ENABLEDELAYEDEXPANSION&set _slf=1&set _inpt="!_inpt:"=!"
	if !_inpt!=="" ENDLOCAL&cls&echo ������Ч�������ԡ�����&echo,&goto :_rip
	if !_inpt!=="y" (set _id=1&set _otn=Hosts
	    for /f "eol=# tokens=1" %%m in (%windir%\system32\drivers\etc\hosts) do (
		set "_tin=%%m"	&rem %%m-IP���������ñ���ȥ���ظ���
		if not defined #!_tin! if %%m neq 127.0.0.1 (set #!_tin!=#&set "_ipt=!_tin!"&call :_fle
		    if not defined _psf (
			call :_tSNI
			if !_id! gtr 999 (set "_sp=") else if !_id! gtr 99 (set "_sp= ") else if !_id! gtr 9 (set "_sp=  ") else set "_sp=   "
			echo,*!_sp!!_id!	!_ipt!	!_r!
			echo,!_id!,!_ipt!,!_r!>>"!_otn!_!_otf!"&set/a_id+=1
		    )
		)
	    )
	    for /f "eol=# tokens=1" %%m in (%windir%\system32\drivers\etc\hosts) do (
		if defined #%%m set #%%m=
	    )
	    if !_id! gtr 1 echo,&echo -----����ļ���"!_fdp!!_otn!_!_otf!"
	    ENDLOCAL
	) else (
	    for %%n in (!_inpt!) do (
		if defined _slf ENDLOCAL
		if exist "%%~fn\" (cls&echo "%%~fn"��Ŀ¼��������Ч���ļ���&echo,&goto :_rip) else if exist "%%~fn" (
		    title "%~f0" "%%~fn"&set _id=1&set "_otn=%%~nn"
		    for /f "eol=# usebackq" %%p in ("%%~fn") do (set "_ipt=%%~p"&call :_fle
			if not defined _psf (SETLOCAL ENABLEDELAYEDEXPANSION&call :_tSNI
			    if !_id! gtr 999 (set "_sp=") else if !_id! gtr 99 (set "_sp= ") else if !_id! gtr 9 (set "_sp=  ") else set "_sp=   "
			    echo,*!_sp!!_id!	!_ipt!	!_r!
			    echo,!_id!,!_ipt!,!_r!>>"!_otn!_!_otf!"
			    for %%c in ("!_otf!")do ENDLOCAL&set "_otf=%%~c"&set/a_id+=1
			)
		    )
		    SETLOCAL ENABLEDELAYEDEXPANSION&(if !_id! gtr 1 echo,&echo -----����ļ���"!_fdp!!_otn!_!_otf!")&ENDLOCAL
		) else cls&echo �ļ������ڣ�"%%~fn"&echo,&goto :_rip
	    )
	    if defined _slf ENDLOCAL&rem ���!_inpt!����ͨ�����û��ƥ����ļ�ʱ��for����ִ�У������Ҫ����ENDLOCAL
	)
    ) else cls&echo ������Ч�������ԡ�����&echo,&goto :_rip
)

echo,&echo ��ɣ���������˳���&pause>nul
goto :eof

:_fle	rem ����������Ч����֤
    SETLOCAL ENABLEDELAYEDEXPANSION&rem echo ���룺!_ipt!
    set _isf=&set _psf=
    if defined _ipt (rem �ж��Ƿ��������Լ���Ч�ַ�
	set "_in1=!_ipt:"=#!"
	set "_in2=!_ipt:"=@!"
	if "!_in1!" neq "!_in2!" ENDLOCAL&set _psf=1&goto :eof	rem !_ipt!�������ţ����ܼ����ж�
	for /f "tokens=*delims=0123456789.abcdefghijklmnopqrstuvwxyz-ABCDEFGHIJKLMNOPQRSTUVWXYZ eol=" %%a in ("!_ipt!")do if "%%a" neq "" set _psf=1
    ) else set _psf=1&rem echo in :_fle ������Ч��

    if defined _psf (ENDLOCAL&set _psf=1&goto :eof)else (
	set _in1=!_ipt:..=!
	if "!_in1!" neq "!_ipt!" set _psf=1&rem echo �ж�����������
	set _b=!_ipt:~0,1!&set _e=!_ipt:~-1!
	if "!_b!"=="." set _psf=1&rem echo ���ж����㡣����
rem	if "!_e!"=="." set _psf=1&rem echo β�ж����㡣����
	set _in2=!_ipt:.=;!
	if "!_in2!"=="!_ipt!" set _psf=1&rem echo ��������㡣����

	set/a_ii=_it=0
	for %%c in (!_in2!) do (
	    set/a_ii+=1&set _!_ii!=%%c
	    if %%c leq 255 if %%c geq 0 set/a_it+=1
	    call set _bb=%%_!_ii!:~0,1%%&call set _ee=%%_!_ii!:~-1%%
	    if !_bb!==- set _psf=1&rem echo �ж���ĺ���-��
	    if !_ee!==- set _psf=1&rem echo �ж���ĺ���-��
	)
	for /f "tokens=*delims=0123456789. eol=" %%a in ("!_ipt!") do if "%%a"=="" if !_e! neq . if !_it! equ 4 if !_ii! equ 4 set _isf=1
	if not defined _isf set _psf=1&rem echo ������Ч��IP
    )
    if defined _psf ENDLOCAL&set _psf=1
goto :eof

:_tSNI
    if #%1==# if %_id%==1 (
	set _d=!date:~0,10!_!time:~0,-3!&set _d=!_d: =0!&set _d=!_d:/=!&set _d=!_d:-=!&set _d=!_d:.=!
	set "_otf=SNI-Test_!_d::=!.csv"&echo,%_pmt%>"%_otn%_!_otf!")
    %_c%google.com/%_q%
goto :eof


rem curl -sm2 --resolve g.co:443:%1 https://g.co/favicon.ico

curl -m2 --resolve www.google.com:443:203.210.8.42 https://www.google.com
curl -sm2 --resolve g.co:443:203.210.8.19 https://g.co/favicon.ico>nul&&set _r=1||set _r=0
curl -sm2 --resolve a.akamaihd.net:443:203.210.8.19 https://a.akamaihd.net>nul&&echo OK||echo No

curl -sm2 --connect-to ::203.210.8.37 https://www.google.com/ncr
curl -km2 --connect-to ::203.210.8.37 https://www.google.com/ncr