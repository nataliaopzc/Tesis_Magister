function [fitresult, gof] = createFit_pond(A)
%CREATEFIT(A)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      Y Output: A
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 27-Mar-2018 17:52:40


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( [], A );

% Set up fittype and options.
ft = fittype( 'a*exp(b*x)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.825138506386128 0.0892240503380921 0.359589909123178];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
%figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData);
legend( h, 'Mediana', 'Fitt, f(x)=a*exp(bx)+c', 'Location', 'Southeast' );
% Label axes
ylabel A
grid on


