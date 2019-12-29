# all files/dirs prefixed with _
HOME_FILES=_*

# only directories not prefixed with _
CONF_DIRS=`ls -d [!_]*/`

default: deploy

deploy:
	for F in ${HOME_FILES}; do ln -s $$PWD/$$F $$HOME/`basename $$F | sed s/_/./`; done
	for F in ${CONF_DIRS}; do ln -s $$PWD/$$F $$HOME/.config/`basename $$F`; done

clean:
	for F in ${HOME_FILES}; do unlink $$HOME/`basename $$F | sed s/_/./`; done
	for F in ${CONF_DIRS}; do unlink $$HOME/.config/`basename $$F`; done

test:
	for F in ${CONF_DIRS}; do echo $$F; done

.PHONY: deploy clean test
