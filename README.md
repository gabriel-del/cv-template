# CV-BUILDER

Create a custom resume from linkedin resume

## Dependencies

* texlive-core
* texlive-pictures
* texlive-latexextra
* texlive-fontsextra
* translate-shell


## Fix latex fonts

https://wiki.archlinux.org/title/TeX_Live

```bash
sudo ln -s /usr/share/texmf-dist/fonts/opentype/public/erewhon /usr/share/fonts/OTF/
sudo ln -s /usr/share/texmf-dist/fonts/opentype/public/erewhon-math /usr/share/fonts/OTF/
sudo ln -s /usr/share/texmf-dist/fonts/opentype/public/fontawesome /usr/share/fonts/OTF/
```

or

```bash
sudo ln -s /usr/share/fontconfig/conf.avail/09-texlive-fonts.conf /etc/fonts/conf.d/09-texlive-fonts.conf
sudo fc-cache && sudo mkfontscale && sudo mkfontdir
```

# Usage

Put your **resume-*.pdf** on the root directory, also a **profile.jpeg** picture.

`make config`

`make move`

Modify variable **LOCATION** on 
**sections/contact.tex** , **sections/en/education** and **sections/en/experience.tex**

Update **sections/programming.tex**, **sections/qrcode.tex**  and **sections/en/languages.tex**

Adjust anything else you find necessary on **sections/**

`make translate`

Adjust anything else you find necessary again on **sections/pt/**

`make`

Then you can find the .pdf's on **tmp/log/**.