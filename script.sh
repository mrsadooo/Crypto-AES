set terminal x11 size 1024,768 enhanced font 'Verdana,10' persist
set title "Raw image data" 
set xrange [ -10.0000 : 1024.000 ] noreverse nowriteback
set yrange [ -10.0000 : 1024.000 ] noreverse nowriteback
plot 'plain_image_cbc.raw.enc' binary array=1024x976 flipy format='%uchar' with rgbimage