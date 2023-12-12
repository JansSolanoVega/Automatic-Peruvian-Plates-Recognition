function [caracter]=PredictCharacter(img,i)
    nn=load("firstnn.mat");
    img = imresize(img, [28, 28]);
    texto_prediccion=predict(nn.trainedNetwork_1, img);
    %FORMATO
    if i>=4,
        texto_prediccion=texto_prediccion(1:10);
    elseif ~(i==2),    
        texto_prediccion(1:10)=0;
    end
    
    
    [valu, arg]= max(texto_prediccion);
    if arg<=10,
        caracter=char('0'+arg-1);
    elseif arg<=24,
        caracter=char('A'+arg-11);
    else,
        caracter=char('A'+arg-10);
    end
    
    if caracter=='Q',
        caracter='A';
    end
    display("El caracter es: "+ caracter)
end