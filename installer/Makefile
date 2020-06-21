build:
	pwsh -file build.ps1

tidy:
	tidy -xml --doctype strict -w 1000 -q -i -c -modify quserwrapper.wxs

do_once_only:
	pwsh -file do_once_only.ps1
	dos2unix quserwrapper.wxs

clean:
	rm -rf Work
	rm -rf Output
	rm -f *.wixobj
