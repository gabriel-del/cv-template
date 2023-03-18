# CV-BUILDER


## Dependencies

* texlive-core
* texlive-pictures
* texlive-latexextra
* texlive-fontsextra


Fix latex fonts
https://wiki.archlinux.org/title/TeX_Live
sudo ln -s /usr/share/texmf-dist/fonts/opentype/public/erewhon /usr/share/fonts/OTF/
sudo ln -s /usr/share/texmf-dist/fonts/opentype/public/erewhon-math /usr/share/fonts/OTF/
sudo ln -s /usr/share/texmf-dist/fonts/opentype/public/fontawesome /usr/share/fonts/OTF/

or

sudo ln -s /usr/share/fontconfig/conf.avail/09-texlive-fonts.conf /etc/fonts/conf.d/09-texlive-fonts.conf
sudo fc-cache && sudo mkfontscale && sudo mkfontdir


Put LOCATION on education.tex and experience.tex
Put  profile.jpeg
update languages.tex and programming.tex
