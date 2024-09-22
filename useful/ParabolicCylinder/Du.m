%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u=Du(a,x)
%       ===================================================================
%       Purpose: Compute parabolic cylinder function U(a,x)
%       Input  : a --- Parameter (|a| < 5)
%                x --- Argument (|x| < 5)
%       Output : u ------ U(a,x)
%       ===================================================================
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This program was inspired by the Matlab program 'specfun' (author
%  B. Barrowes) which is a direct conversion by 'f2matlab' (author
%  B. Barrowes) of the corresponding Fortran program in
%  S. Zhang and J. Jin, 'Computation of Special functions' (Wiley, 1966).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  E. Cojocaru, January 2009
%  Observations, suggestions and recommendations are welcome at e-mail:
%   ecojocaru@theory.nipne.ro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u = pu(-a-0.5,x);

end