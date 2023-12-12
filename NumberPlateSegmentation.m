function [final_output]=NumberPlateSegmentation(im)   
    im=rgb2gray(im);
    I=im;  %Se almacena la imagen original en escala de grises
    im=imbinarize(im);
    %imshow(im)
    
    se0 = strel('line',1,1); %Separación de líneas
    cierre = imdilate(im,se0);
    se = strel('line',1,1); %Unión de líneas
    im = imerode(cierre,se);
    %figure
    %imshow(im), title("Morfologicas")
    
    
    [~,cc]=size(im);
    %Redimensionamiento
    im_placa=imresize(im,[300 500]);
    I=imresize(I,[300 500]); %Se hace el resize también a la imagen gray
    %im_placa=im(70:280,1:500);
    %im_pais=im(1:70,1:500);
    
    %Deteccion de los 6 caracteres de placa
    
    %Inversión
    im_placa=1-im_placa;
    im_placa=bwareaopen(im_placa,2000);
    etiquetado=figure; %CAMBIO
    imshow(im_placa);%title("bwareaopen")
    
    
    %Etiquetado de elementos
    [L,Ne]=bwlabel(im_placa);
    propiedades=regionprops(L,'BoundingBox');
    hold on
    pause(1)
    %Se genera el rectangulo azul que bordean los caracteres
    for n=1:size(propiedades,1)
      rectangle('Position',propiedades(n).BoundingBox,'EdgeColor','b','LineWidth',2)
    end
    exportgraphics(etiquetado, 'AppFiles/caracteres.jpg');
    close(etiquetado);

    hold off
    
    %Arreglos vacios
    final_output=[];
    t=[];
    
    %Se muestra cada caracter detectado en rectangulos previamente
    for n=1:Ne
      [r,c] = find(L==n);
      n1=I(min(r):max(r),min(c):max(c));
      n1=imresize(n1,[42,24]);
      
      x=[ ];
      
%       n1=imbinarize(n1);
%       n1=1-n1;
      %figure,imshow(n1)
      pause(0.2)
      
      [caracter]=PredictCharacter(n1,n) %Se predice el caracter
      final_output=[final_output,caracter];
    %Almacena los caracteres detectados antes
    %totalLetters=size(imgfile,2);
    end
end