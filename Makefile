.PHONY: all clean 

SPLC_FLAGS = -a -v 
SPLC = $(STREAMS_INSTALL)/bin/sc

SPL_CMD_ARGS ?= --data-directory=data 
SPL_MAIN_COMPOSITE = com.ibm.streamsx.messaging.rabbitmq::RABBITMQComposite

INC_PATH =\

CXX_FLAGS = -std=gnu++0x -g

all: distributed

classes:
	$(MAVEN_HOME)/bin/mvn package -f impl/java/pom.xml; 

DEPS: classes

standalone: DEPS
	$(SPLC) $(SPLC_FLAGS) -T -M $(SPL_MAIN_COMPOSITE) $(SPL_CMD_ARGS) 

distributed: DEPS
	$(SPLC) $(SPLC_FLAGS) -M $(SPL_MAIN_COMPOSITE) $(SPL_CMD_ARGS) 

clean: 
	$(SPLC) $(SPLC_FLAGS) -C -M $(SPL_MAIN_COMPOSITE)
	$(MAVEN_HOME)/bin/mvn clean -f impl/java/pom.xml

