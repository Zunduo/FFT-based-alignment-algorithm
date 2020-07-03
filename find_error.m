function [error_z,error_y]=find_error(image1,image2,z_shift,y_shift)

if(strcmp(image1,'img1.png') && strcmp(image2,'img2.png'))
    actual_z = -4;
    actual_y = 2.4;
elseif(strcmp(image1,'img1.png') && strcmp(image2,'img3.png'))   
    actual_z = -8;
    actual_y = 4.8;
elseif(strcmp(image1,'img1.png') && strcmp(image2,'img4.png'))   
    actual_z = -4.32;
    actual_y = 7.2;
elseif(strcmp(image1,'img1.png') && strcmp(image2,'img5.png'))   
    actual_z = -12;
    actual_y = 7.2;
elseif(strcmp(image1,'img2.png') && strcmp(image2,'img3.png'))   
    actual_z = -4;
    actual_y = 2.4;
elseif(strcmp(image1,'img2.png') && strcmp(image2,'img4.png'))   
    actual_z = -0.32;
    actual_y = 4.8;
elseif(strcmp(image1,'img2.png') && strcmp(image2,'img5.png'))   
    actual_z = -8;
    actual_y = 4.8;
elseif(strcmp(image1,'img3.png') && strcmp(image2,'img4.png'))   
    actual_z = 3.68;
    actual_y = 2.4;
elseif(strcmp(image1,'img3.png') && strcmp(image2,'img5.png'))   
    actual_z = -4;
    actual_y = 2.4;
elseif(strcmp(image1,'img4.png') && strcmp(image2,'img5.png'))   
    actual_z = -7.68;
    actual_y = 0;
end

%error_z = abs(z_shift-actual_z)/abs(actual_z)*100;
%error_y = abs(y_shift-actual_y)/abs(actual_y)*100;
error_z = abs(z_shift - actual_z);
error_y = abs(y_shift - actual_y);

fprintf('    actual offset:\n    z = %f, y = %f\n',actual_z,actual_y)
fprintf('    error in offset:\n    z = %f, y = %f\n\n',error_z,error_y)

end