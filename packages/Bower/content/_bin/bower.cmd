@echo off
SET PATH=%~dp0;%PATH%
"%~dp0node" "%~dp0..\..\packages\Bower.{%PACKAGE_VERSION%}\node_modules\bower\bin\bower" %*