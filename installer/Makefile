Output/product.msi:
	pwsh -File build.ps1

install:
	msiexec /i 'Output\product.msi'

uninsall:
	msiexec /qn /x 'Output\product.msi'

test_uninstall:
	pwsh -Command 'Invoke-Pester -Script .\tests\Clean.Tests.ps1 Uninstall'

test_install:
	pwsh -Command 'Invoke-Pester -Script .\tests\Clean.Tests.ps1 Install'

in: install
un: uninsall
ti: test_install
tu: test_uninstall

tidy:
	tidy -xml --doctype strict -w 1000 -q -i -c -modify product.wxs.tmpl
	unix2dos product.wxs.tmpl

clean:
	rm -rf Work
	rm -rf Output
	rm -f *.wixobj
