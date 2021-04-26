function [h, display_array] = displayData(X, example_width)
%DISPLAYDATA Display 2D data in a nice grid
%   [h, display_array] = DISPLAYDATA(X, example_width) displays 2D data
%   stored in X in a nice grid. It returns the figure handle h and the 
%   displayed array if requested.

% Set example_width automatically if not passed in
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2)));
  % size(X,2) 400 features in a picture 
  %example_width   % it is 20 
  % size(X,1)   this is 100 
end

%x(1:10)=X(1:10);
%x(2:10)=X(10:20);
%x(3:10)=X(20:30);
%x(4:10)=X(30:40);
%x(5:10)=X(40:50);
%x(6:10)=X(50:60);
%x(7:10)=X(60:70);
%x(8:10)=X(70:80);
%x(9:10)=X(80:90);
%x(10:10)=X(90:100);

% Gray Image
colormap(gray);

% Compute rows, cols
[m n] = size(X);   %  100 x 400
example_height = (n / example_width);  % 20

% Compute number of items to display
display_rows = floor(sqrt(m));      % 10
display_cols = ceil(m / display_rows);   % 10

% Between images padding
pad = 1;

% Setup blank display
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad));
% (211,211) above line dimensions ,print -1 in all the segments 
%[a b]=size(display_array);
%a 211
%b 211
%fprintf(" we are here ");
% Copy each example into a patch on the display array

curr_ex = 1;
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		% Copy the patch
		
		% Get the max value of the patch
		max_val = max(abs(X(curr_ex, :)));
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% Display Image
h = imagesc(display_array, [-1 1]);

% Do not show axis
axis image off

drawnow;

end
