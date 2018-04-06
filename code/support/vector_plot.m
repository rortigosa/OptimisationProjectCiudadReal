function       vector_plot(position,vector)


initial_vector_position  =  position;
initial_vector_position  =  reshape(initial_vector_position,max(size(position)),1);
final_vector_position    =  position + vector;
final_vector_position     =  reshape(final_vector_position,max(size(position)),1);
information              =  [initial_vector_position   final_vector_position];


dim  =  max(size(position));
switch dim
    case 2
         plot(information(1,:),information(2,:),'-')         
    case 3
         plot3(information(1,:),information(2,:),information(3,:),'-')         
end
    
    
