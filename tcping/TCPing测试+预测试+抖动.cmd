@echo off&title "%~f0"&cd /d "%~dp0"&set "_fdp=%~dp0"
rem ���Ϸ��ļ���������ʱ��Ĭ��Ŀ¼���ǵ�ǰ����������Ŀ¼��%~dp0�������û�����Ŀ¼��%USERPROFILE%
for /f "tokens=3-4delims=. " %%c in ('tcping -v 2^>nul') do set _pv=%%c%%d&goto :next
:next
if defined _pv (if 1%_pv% lss 1027 echo,tcping.exe version is too old, please update!&pause>nul&goto :EOF) else echo,tcping.exe does not exist! please download:&echo,https://www.elifulkerson.com/projects/tcping.php&pause>nul&goto :EOF

set _tw=1&set _ti=.3&set/a_tn=10,_p=443,_e80=0,_prt=1,_tpn=3
rem _tn��ping�Ĵ���(tcping -n����ֵ)��_p��Ĭ�϶˿ڣ�_e80���Ƿ����TCP:80�˿ڣ�_prt���Ƿ����Ԥ����
rem _tw����ʱʱ��(tcping -w����ֵ)��_ti���������(tcping -i����ֵ)������Ϊ��λ����֧��С����_tpn Ԥ����ping�Ĵ���
if %_tn% geq 6 (set/a_g=_tn/2) else set _g=%_tn%
rem �ۻ���_g��pingʧ��(tcping -g����ֵ)������ֹ��ǰping
set _pmt=���,����,����IP,��С,���,ƽ��,����,����
if "%_e80%"=="1" set _pmt=%_pmt%,F80,J80

echo ������һ���˿ںţ�[1-65535]��
set /p _pt=�س�ʹ��Ĭ�϶˿ڣ�%_p%����&echo,
if defined _pt if %_pt%0 geq 10 if %_pt%0 leq 655350 set _p=%_pt%

if "%~d1" neq "" (
    echo ��⵽�����������������&echo,
    set "str=%cmdcmdline:"=%"
    SETLOCAL ENABLEDELAYEDEXPANSION&set _slf=1
    set "str=!str:%~f0 =!"
    set "str=!str: %~d1=" "%~d1!"
    for %%n in ("!str!") do (
	if defined _slf ENDLOCAL
	if exist "%%~fn\" (cls&echo "%%~fn"��Ŀ¼��������Ч���ļ���������&echo,) else if exist "%%~fn" (
	    set _id=1&set "_otn=%%~nn"
	    for /f "eol=# usebackq" %%p in ("%%~fn") do (set "_ipt=%%p"&call :_fle
		if not defined _psf (SETLOCAL ENABLEDELAYEDEXPANSION
		    set _Min=-&set _Max=-&set _Avg=-&set _fal=-&set _jtr=-&call :_pn %_p%
		    if "%_e80%"=="1" (set _f80=,-&set _j80=,-&if !_ip:~-1! neq �� call :_pn
			if "!_f80!"==",x_%_tpn%" (set _fj8=!_f80:~1!) else set "_fj8=x!_f80:~2,-1!_(!_j80:~2!)"
		    ) else set _fj8=_
		    echo,*!_id!...!_ipt!==!_ip!__!_Min!ms^|!_Max!ms^|!_Avg!ms__x!_fal:~1,-1!_(!_jtr:~1!^)__!_fj8!...
		    echo,!_id!,!_ipt!,!_ip!,!_Min!,!_Max!,!_Avg!,!_fal!,!_jtr!!_f80!!_j80!>>"!_otn!_!_otf!"&rem �˴���%%���ñ�����Ч
		    for %%c in ("!_otf!")do ENDLOCAL&set "_otf=%%~c"&set/a_id+=1
		)
	    )
	    SETLOCAL ENABLEDELAYEDEXPANSION&(if !_id! gtr 1 echo,&echo -----����ļ���"!_fdp!!_otn!_!_otf!")&ENDLOCAL
	)
    )
) else (
    :_rip
    echo ������ û�������ļ����رճ��򣬻��ߣ�������&echo �٣����롰Y������д���ӱ���Hosts��ȡ������
    echo �ڣ����롰y����Сд���ӱ���Hosts��ȡIP��&echo �ۣ����롰��������������IP�����ļ�·����
    set _inpt=&set /p _inpt=�ܣ�������������IP�б���ļ��Ϸŵ��������ڣ��س��Լ�����

    if defined _inpt (
	SETLOCAL ENABLEDELAYEDEXPANSION&set _slf=1&set _inpt="!_inpt:"=!"
	if !_inpt!=="" ENDLOCAL&cls&echo ������Ч�������ԡ�����&echo,&goto :_rip
	if !_inpt!=="y" set _iip=1&set _inpt="Y"
	if !_inpt!=="Y" (set _id=1&set _otn=Hosts
	    for /f "eol=# tokens=1,2" %%m in (%windir%\system32\drivers\etc\hosts) do (
		if !_iip! equ 1 (set "_tin=%%m") else set "_tin=%%n"	&rem %%m-IP��%%n-�������������ñ���ȥ���ظ���
		if not defined #!_tin! if %%m neq 127.0.0.1 (set #!_tin!=#&set "_ipt=!_tin!"&call :_fle
		    if not defined _psf (
			set _Min=-&set _Max=-&set _Avg=-&set _fal=-&set _jtr=-&call :_pn %_p%
			if "%_e80%"=="1" set _f80=,-&if !_ip:~-1! neq �� call :_pn
			echo,*!_id!...!_ipt!--!_ip!__!_Min!ms^|!_Max!ms^|!_Avg!ms__x!_fal:~1,-1!_!_jtr:~1!__x!_f80!_!_j80!...
			echo,!_id!,!_ipt!,!_ip!,!_Min!,!_Max!,!_Avg!,!_fal!,!_jtr!!_f80!!_j80!>>"!_otn!_!_otf!"&set/a_id+=1
		    )
		)
	    )
	    for /f "eol=# tokens=1,2" %%m in (%windir%\system32\drivers\etc\hosts) do (
		if defined #%%m set #%%m=
		if defined #%%n set #%%n=
	    )
	    if !_id! gtr 1 echo,&echo -----����ļ���"!_fdp!!_otn!_!_otf!"
	    ENDLOCAL
	) else (
	    for %%n in (!_inpt!) do (
		if defined _slf ENDLOCAL
		if exist "%%~fn\" (cls&echo "%%~fn"��Ŀ¼��������Ч���ļ���&echo,&goto :_rip) else if exist "%%~fn" (
			set _id=1&set "_otn=%%~nn"
			for /f "eol=# usebackq" %%p in ("%%~fn") do (set "_ipt=%%~p"&call :_fle
			    if not defined _psf (SETLOCAL ENABLEDELAYEDEXPANSION
				set _Min=-&set _Max=-&set _Avg=-&set _fal=-&set _jtr=-&call :_pn %_p%
				if "%_e80%"=="1" set _f80=,-&if !_ip:~-1! neq �� call :_pn
				echo,*!_id!...!_ipt!---!_ip!__!_Min!ms^|!_Max!ms^|!_Avg!ms__x!_fal:~1,-1!_!_jtr:~1!__x!_f80!_!_j80!...
				echo,!_id!,!_ipt!,!_ip!,!_Min!,!_Max!,!_Avg!,!_fal!,!_jtr!!_f80!!_j80!>>"!_otn!_!_otf!"
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
set _fdp=&set _tw=&set _ti=&set _tn=&set _p=&set _e80=&set _pmt=&set _pt=&set str=&set _pef=&set _id=&set _otn=&set _ipt=&set _inp=&set _otf=

echo,&echo ��ɣ���������˳���&pause>nul&exit

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
	for /f "tokens=*delims=0123456789. eol=" %%a in ("!_ipt!") do if "%%a"=="" (if !_e! neq . if !_it! equ 4 if !_ii! equ 4 set _isf=1) else (
	rem echo ����IP���ж��Ƿ�Ϊ����
	    for %%c in (!_ii!) do set _tld=!_%%c!
	    for /f "tokens=*delims=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%a in ("!_tld!") do if "%%a"=="" (
		for %%z in (com net org info biz name pro edu gov int club asia) do if !_tld!==%%z set _isf=1&rem echo �ǳ�����ͨ��������׺
		if !_tld!==!_tld:~-2! if !_tld! neq !_tld:~-1! set _isf=1&rem echo ������������ĸ�Ĺ���������׺
	    )
	)
	if not defined _isf set _psf=1&rem echo ������Ч��������IP
    )
    if defined _psf ENDLOCAL&set _psf=1
goto :eof

rem ����ӷ� call _add  <������> <����|����>
:_Add
rem �ж�%2�����Ƿ�Ϊ��ֵ���Ѷ���ı�������������������ó�ʼֵ��set %2=0
SETLOCAL ENABLEDELAYEDEXPANSION&if defined %2 (set _2=!%2!) else set/a _ts=%2*1>nul 2>nul&&(if !_ts! equ %2 (
set _2=%2) else ENDLOCAL&set %2=0&SETLOCAL ENABLEDELAYEDEXPANSION&set _2=0)||set _2=%2
for /f "tokens=1-3 delims=." %%a in ("00000000%1.0000") do set at=%%a&set aw=%%b%%c
for /f "tokens=1-3 delims=." %%a in ("00000000%_2%.0000") do set bt=%%a&set bw=%%b%%c
set a=%at:~-8%%aw:~,4%&set b=%bt:~-8%%bw:~,4%&set v=20000
for /l %%i in (8,-4,0)do set/a v=1!b:~%%i,4!+1!a:~%%i,4!+!v:~,1!-2&set e=!v:~-4!!e!
if "!e:0=!"=="" (set e=0) else set e=!e:0= !&(for /f "tokens=*" %%a in ("!e:~,-4!.!e:~8!") do set e=%%~nxa)&if "!e:~,1!"=="." set e=0!e!
(for %%a in ("!e: =0!") do ENDLOCAL&if defined %2 (set %2=%%~a) else echo %%~a)&goto :eof

:_pn
rem ������call����%%�����ⲿ����	echo,out-_ipt==%_ipt%-!_ipt!
    if #%1 neq # if %_id%==1 (
	set _d=!date:~0,10!_!time:~0,-3!&set _d=!_d: =0!&set _d=!_d:/=!&set _d=!_d:-=!&set _d=!_d:.=!
	set "_otf=%1Test_!_d::=!_w%_tw%i%_ti%n%_tn%.csv"&echo,%_pmt%>"%_otn%_!_otf!")

    if %_prt%==1 (
	for /f "tokens=1-4 delims=: " %%a in ('tcping -f -i .3 -w 1 -n %_tpn% %_ipt% %1^|findstr/i "^Ping failed. DNS"') do (
	    if %%a==DNS (set _ip=������������) else (
		if %%a==Ping (if #%1==# (if %%d neq %_ip% set _ip=%_ip%/%%d) else set _ip=%%d) else set _prs=%%a)))

    if "%_prs%"=="0" (if #%1==# (set _f80=,x_%_tpn%) else set _fal=x_%_tpn%) else (
	if !_ip:~-1! neq �� (rem echo,Ԥ����OK����һ������
	for /f "tokens=1-6,10 delims==,:- " %%a in ('tcping -f -j -w %_tw% -i %_ti% -n %_tn% -g %_g% %_ipt% %1^|findstr/i "^Ping open fail Ave DNS"') do (
	    if #%%g neq # (if #%1==# (call :_Add %%g _jt8) else call :_Add %%g _jts) else (
		if "%%c"=="for" (if #%1==# (if %%d neq %_ip% set _ip=%_ip%/%%d) else set _ip=%%d) else if "%%c"=="not" set _ip=������������
		if "%%d"=="failed." (set _scf=%%a&set/a _st=%%a+%%c&set/a _sct=_scf-1&if #%1==# (set "_f80=,=%%c/!_st!%%"
		    if defined _jt8 set _j80=,=!_jt8!/!_sct!) else set "_fal==%%c/!_st!%%"&if defined _jts set _jtr==!_jts!/!_sct!)
			rem set/a _sct=_scf-1,_=!_jts:~,-4!%%_sct&if !_! equ 0 (set/a _=!_jts:~-3!/_sct) else set/a _=!_!!_jts:~-3!/_sct
			rem if !_:~^,1! geq 5 (set/a _jtr=!_jts:~,-4!/_sct+1) else set/a _jtr=!_jts:~,-4!/_sct &rem ������С�����������뱣������
		if "%%e"=="Average" if %_Avg%==- set _Min=%%b&set _Max=%%d&set _Avg=%%f&set _Min=!_Min:~0,-2!&set _Max=!_Max:~0,-2!&set _Avg=!_Avg:~0,-2!))))

rem    echo, %_id%...%_ipt%---%_ip%__%_Min%ms^|%_Max%ms^|%_Avg%ms__%_fal%__%_f80%___
goto :eof

