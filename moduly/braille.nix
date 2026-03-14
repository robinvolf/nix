{...}:{
  # Blacklistuju FreeMono, je na tom závislé mpv, ale funguje i bez toho
  # a jinak to poskytnuje hrozně hnusné braille fonty v btm (⣀⡄⡀)
  fonts.fontconfig.localConf = ''
    <selectfont>
      <rejectfont>
          <pattern>
              <patelt name="family" >
                  <string>FreeMono</string>
              </patelt>
          </pattern>
      </rejectfont>
    </selectfont>
  '';
}
