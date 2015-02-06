function src = create_dreemsrc(labels)


files = [];
classes = {'pos', 'neg'};

%  objects = [];


parfor ind = 1: length(labels) %   files)
    
disp(['runing parfor ...i = ', int2str(ind)]);    
    new_object{ind}.ind = ind;
    new_object{ind}.u1 = 1;
    new_object{ind}.u2 = 600;
    new_object{ind}.cl = labels(ind)*2 - 1;
%     objects(ind) = new_object{ind} ;
end

disp('done parfor');

objects  = new_object{1};
parfor i = 2 : length(labels)
    objects(i) = new_object{i};
end

src.classes = classes;
src.files = files;
src.objects = objects;
end
