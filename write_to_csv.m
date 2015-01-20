function write_to_csv(filename,data)
%Usage : write_to_csv('mysubmission.csv',my_prediction_vector)
%creates a csv file with headers from a vector of predictions.


fid=fopen(filename,'wt');
fh = fopen('headers.txt');

fprintf(fid,'%s\n','id,pred');

for i=1:size(data,1)
        tline = fgetl(fh);
        fprintf(fid,'%s,',tline);
        fprintf(fid,'%s\n',num2str(data(i)));
        
end
fclose(fid);

end