#!/usr/bin/env bash
BANG_DIR=${HOME}/workspace/bangsh/src
#                      __ __       ___
#                     /\ \\ \    /'___`\
#                     \ \ \\ \  /\_\ /\ \
#                      \ \ \\ \_\/_/// /__
#                       \ \__ ,__\ // /_\ \
#                        \/_/\_\_//\______/
#                           \/_/  \/_____/
#                                         Algoritimos
#
#
#       Author: Ivan carlos da Silva Lopes
#         Mail: ivanlopes (at) 42algoritimos (dot) com (dot) br
#      License: gpl
#        Site: http://www.42algoritmos.com.br
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: project.sh
#        Date: Wed 02 Oct 2013 12:55:57 AM BRT
# Description:
#	`<  =code here=  >`
source "$BANG_DIR/bang.sh"
# ----------------------------------------------------------------------------
b.module.require opt

# ----------------------------------------------------------------------------
b.set "Roo.TemplateSourcePath" "/opt/files/java/spring/01"

### Functions ###

function create_makefile() {
cat << EOF >> Makefile
package=$1
project=$2

all: getting-started-with-maven-java-console-app

getting-started-with-maven-java-console-app:
	@mvn archetype:generate -DgroupId=\$(package) -DartifactId=\$(project) -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

clean:
	@mvn clean

compile:
	@mvn console

package:
	@mvn package

run:
	@mvn exec:java -Dexec.mainClass="\$(package).Application"
EOF
}

function roo_script() {
      echo "project --topLevelPackage $1 --java 7 --projectName $2 --packaging JAR" > my.roo
      create_class_with_roo >> my.roo
      roo script my.roo
      copy_src_to_roo_project $(b.get "Roo.TemplateSourcePath") $1
      update_template_package $1

      sed -e 's@.*<plugins>@      <pluginManagement>\n&@' -e 's@.*</plugins>@&\n      </pluginManagement>@' -i pom.xml
}

function copy_src_to_roo_project () {
  cp $1/*.java src/main/java/${2//./\/}/ 
}

function update_template_package () {
   sed "s/package com.foo;/package $1;/" -i src/main/java/${1//./\/}/*.java
}

function create_class_with_roo () {
  echo interface --class ~.MessageService
  echo class --class ~.Application     
  echo class --class ~.MessagePrinter
}

function load_options () {
  # Help (--help and -h added as flags)
  b.opt.add_flag --stderr "Prints to stdeer"

  # package (--package and -t added as options)
  b.opt.add_opt --package "Specify package to roo project"
  b.opt.add_alias --package -p

  # Set required args (will raise errors if not specified)
  b.opt.required_args --package

  # name (--name and -t added as options)
  b.opt.add_opt --name "Set project Name"
  b.opt.add_alias --name -n

  # Set required args (will raise errors if not specified)
  b.opt.required_args --name
}

function run () {
  load_options
  b.opt.init "$@"
  if b.opt.check_required_args; then
    local package="$(b.opt.get_opt --package)"
    local name="$(b.opt.get_opt --name)"
    if b.opt.has_flag? --stderr; then
      echo "project --topLevelPackage $package --java 7 --projectName $name --packaging JAR" 1>&2
    else
      roo_script $package $name
      create_makefile $package $name
    fi
  fi
}

##############################################################################
##############################################################################
##############################################################################

# ----------------------------------------------------------------------------

# Run!
b.try.do run "$@"
b.catch RequiredOptionNotSet b.opt.show_usage
b.try.end
# ----------------------------------------------------------------------------
exit 0
xit 0
