#!/bin/bash
echo '[*] riak-browser v0.1 installer'
echo '[*] uses curl for uploading files'
#hostname
echo -n '[cfg] riak hostname (localhost):'
read riakhostname
if [ -z $riakhostname ]; then 
  riakhostname='localhost' 
fi
#port
echo -n '[cfg] riak port (8098):'
read riakport
if [ -z $riakport ]; then 
  riakport='8098' 
fi
#location
echo -n '[cfg] riak location (riak):'
read riaklocation
if [ -z $riaklocation ]; then 
  riaklocation='riak' 
fi
#bucket
echo -n '[cfg] riak-browser bucket (riak-browser):'
read riaktargetbucket
if [ -z $riaktargetbucket ]; then 
  riaktargetbucket='riak-browser' 
fi
#index
index='index.html'

url="http://$riakhostname:$riakport/$riaklocation/$riaktargetbucket/"
echo "[*] installing files to $url"

files=(index.html 
jquery-1.4.1.min.js 
jquery-ui-1.8.7.custom.min.js 
jquery-ui-1.8.7.custom.css
ui-bg_glass_55_fbf9ee_1x400.png
ui-icons_222222_256x240.png
ui-bg_glass_65_ffffff_1x400.png
ui-bg_glass_95_fef1ec_1x400.png
ui-bg_glass_75_e6e6e6_1x400.png
ui-bg_glass_75_dadada_1x400.png
ui-icons_cd0a0a_256x240.png
ui-bg_flat_0_aaaaaa_40x100.png
ui-icons_454545_256x240.png
ui-bg_highlight-soft_75_cccccc_1x100.png
ui-icons_888888_256x240.png
ui-bg_flat_75_ffffff_40x100.png
ui-icons_2e83ff_256x240.png
)
for file in ${files[@]}
 do
  echo "Uploading $file..."
  case $file in
    *.html )
      content_type="Content-Type: text/html"
      ;;
    *.js )
      content_type="Content-Type: text/javascript"
      ;;
    *.css )
      content_type="Content-Type: text/css"
      ;;
    *.png )
      content_type="Content-Type: image/png"
      ;;
  esac

  curl --silent -X PUT -H "${content_type}" --data-binary @$file "$url$file";

done

echo "[*] riak-browser installed, point your browser at:"
echo "[*] $url$index"
