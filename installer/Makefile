build:
	pwsh -File build.ps1

tidy:
	tidy -xml --doctype strict -w 1000 -q -i -c -modify product.wxs.tmpl
	unix2dos product.wxs.tmpl

test:
	pwsh -Command 'Invoke-Pester'

clean:
	rm -rf Work
	rm -rf Output
	rm -f *.wixobj
