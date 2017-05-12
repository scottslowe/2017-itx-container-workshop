PHANTOMJS=/opt/decktape/phantomjs
DECKTAPE=/opt/decktape/decktape.js

%.pdf: presentation.md presentation.html style.css
	@$(PHANTOMJS) --ignore-ssl-errors=true $(DECKTAPE) remark presentation.html $@

slides: presentation.md presentation.html style.css
	@$(PHANTOMJS) --ignore-ssl-errors=true $(DECKTAPE) remark presentation.html slides.pdf
