function [z_shift,y_shift]=compute_shift(image1,image2,plot_flags)

%read in first awesome grapefruit pic
I1 = imread(image1);
r1 = sum(I1,1);
c1 = sum(I1,2);

%read in second awesome grapefruit pic
I2 = imread(image2);
r2 = sum(I2,1);
c2 = sum(I2,2);

%generate Hamming Window
hamming_r1 = hamming(length(r1));
hamming_c1 = hamming(length(c1));
hamming_r2 = hamming(length(r2));
hamming_c2 = hamming(length(c2));

hamming_r1 = hamming_r1';
hamming_r2 = hamming_r2';

window_r1 = r1.*hamming_r1;
window_r2 = r2.*hamming_r2;
window_c1 = c1.*hamming_c1;
window_c2 = c2.*hamming_c2;

% %display images
% figure(1)
% imshow(I1);
% figure(2);
% imshow(I2);

%obtain FFT of windowed vectors
fft_r1 = fft(window_r1);
fft_r2 = fft(window_r2);
fft_c1 = fft(window_c1);
fft_c2 = fft(window_c2);

%normalize vector to obtain row phase correlation
row_correlation = (fft_r1.*conj(fft_r2))./abs(fft_r1.*conj(fft_r2));
col_correlation = (fft_c1.*conj(fft_c2))./abs(fft_c1.*conj(fft_c2));

%shift signal and find stop/end point of slope measurement
% row_corr_original = row_correlation;
row_correlation = fftshift(row_correlation);
[start_point_row,end_point_row] = find_boundaries(image1,image2,row_correlation,plot_flags,1);
extracted_row_corr = row_correlation(start_point_row:end_point_row);

% col_corr_original = col_correlation;
col_correlation = fftshift(col_correlation);
[start_point_col,end_point_col] = find_boundaries(image1,image2,col_correlation,plot_flags,0);
extracted_col_corr = col_correlation(start_point_col:end_point_col);

%find slope
p_row = polyfit(1:length(extracted_row_corr),angle(extracted_row_corr),1);
p_col = polyfit([1:length(extracted_col_corr)]',angle(extracted_col_corr),1);

if plot_flags
    figure;
    subplot(211)
    hold on
    plot(angle(extracted_row_corr))
    plot([1 end_point_row-start_point_row+1],p_row(1).*[1 end_point_row-start_point_row+1]+p_row(2))
    title(['Linear Fit for Extracted Row Phase Signal of ' image1 ' vs ' image2])
    hold off
    subplot(212)
    hold on
    plot(angle(extracted_col_corr))
    plot([1 end_point_col-start_point_col+1],p_col(1).*[1 end_point_col-start_point_col+1]+p_col(2))
    title(['Linear Fit for Extracted Column Phase Signal of ' image1 ' vs ' image2])
    hold off
end
scale_factor = -256/(2*pi);
y_shift = p_row(1)*scale_factor;
z_shift = p_col(1)*scale_factor;

fprintf('%s and %s\n    computed offset:\n    z = %f, y = %f\n',image1,image2,z_shift,y_shift)

%find percent error
% [error_z,error_y]=find_error(image1,image2,z_shift,y_shift);
    
end
