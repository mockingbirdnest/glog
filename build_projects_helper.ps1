# This script helps creating project files for glog.  The argument is the path of glog/.
# It produces two pairs of *.vcxproj, *.vcxproj.filters files: one for the project itself, one for its tests.

$dir = resolve-path $args[0]

$filtersheaders = "  <ItemGroup>`r`n"
$vcxprojheaders = "  <ItemGroup>`r`n"
Get-ChildItem "$dir\src\windows\glog\*" -Recurse -Include *.h | `
Foreach-Object {
  $msvcrelativepath = $_.FullName -replace ".*src\\", "..\..\src\"
  $filtersheaders +=
      "    <ClInclude Include=`"$msvcrelativepath`">`r`n" +
      "       <Filter>Header Files</Filter>`r`n" +
      "    </ClInclude>`r`n"
  $vcxprojheaders +=
      "    <ClInclude Include=`"$msvcrelativepath`" />`r`n"
}
$filtersheaders += "  </ItemGroup>`r`n"
$vcxprojheaders += "  </ItemGroup>`r`n"

$filterssources = "  <ItemGroup>`r`n"
$vcxprojsources = "  <ItemGroup>`r`n"
Get-ChildItem "$dir\src\*" -Recurse -Include *.h | `
Foreach-Object {
  If ( $_.FullName -notmatch ".*windows\\glog") {
    $msvcrelativepath = $_.FullName -replace ".*src\\", "..\..\src\"
    $filterssources +=
        "    <ClInclude Include=`"$msvcrelativepath`">`r`n" +
        "       <Filter>Source Files</Filter>`r`n" +
        "    </ClInclude>`r`n"
    $vcxprojsources +=
        "    <ClInclude Include=`"$msvcrelativepath`" />`r`n"
  }
}
Get-ChildItem "$dir\src\*" -Recurse -Include *.cc -Exclude *test*.cc | `
Foreach-Object {
  $msvcrelativepath = $_.FullName -replace ".*src\\", "..\..\src\"
  $filterssources +=
      "    <ClCompile Include=`"$msvcrelativepath`">`r`n" +
      "       <Filter>Source Files</Filter>`r`n" +
      "    </ClCompile>`r`n"
  $vcxprojsources +=
      "    <ClCompile Include=`"$msvcrelativepath`" />`r`n"
}
$filterssources += "  </ItemGroup>`r`n"
$vcxprojsources += "  </ItemGroup>`r`n"

$filterstests = "  <ItemGroup>`r`n"
$vcxprojtests = "  <ItemGroup>`r`n"
Get-ChildItem "$dir\src\*" -Recurse -Include *test*.h | `
Foreach-Object {
  $msvcrelativepath = $_.FullName -replace ".*src\\", "..\..\src\"
  $filterstests +=
      "    <ClInclude Include=`"$msvcrelativepath`">`r`n" +
      "       <Filter>Source Files</Filter>`r`n" +
      "    </ClInclude>`r`n"
  $vcxprojtests +=
      "    <ClInclude Include=`"$msvcrelativepath`" />`r`n"
}
Get-ChildItem "$dir\src\*" -Recurse -Include *test*.cc | `
Foreach-Object {
  $msvcrelativepath = $_.FullName -replace ".*src\\", "..\..\src\"
  $filterstests +=
      "    <ClCompile Include=`"$msvcrelativepath`">`r`n" +
      "       <Filter>Source Files</Filter>`r`n" +
      "    </ClCompile>`r`n"
  $vcxprojtests +=
      "    <ClCompile Include=`"$msvcrelativepath`" />`r`n"
}
$filterstests += "  </ItemGroup>`r`n"
$vcxprojtests += "  </ItemGroup>`r`n"

$dirfilterspath = [string]::format("{0}\glog_vcxproj_filters.txt", $dir)
[system.io.file]::writealltext(
    $dirfilterspath,
    $filtersheaders + $filterssources,
    [system.text.encoding]::utf8)

$testsfilterspath = [string]::format("{0}\glog_tests_vcxproj_filters.txt", $dir)
[system.io.file]::writealltext(
    $testsfilterspath,
    $filterstests,
    [system.text.encoding]::utf8)

$dirvcxprojpath = [string]::format("{0}\glog_vcxproj.txt", $dir)
[system.io.file]::writealltext(
    $dirvcxprojpath,
    $vcxprojheaders + $vcxprojsources,
    [system.text.encoding]::utf8)

$testsvcxprojpath = [string]::format("{0}\glog_tests_vcxproj.txt", $dir)
[system.io.file]::writealltext(
    $testsvcxprojpath,
    $vcxprojtests,
    [system.text.encoding]::utf8)
