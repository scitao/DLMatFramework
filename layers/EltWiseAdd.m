classdef EltWiseAdd < BaseLayer
    %EltWiseAdd Summary of this class goes here
    
    
    properties (Access = 'protected') 
        weights
        biases
        activations
        gradients
        config
        previousInput
        previousInput1
        previousInput2
        name
        index
        activationShape
        weightShape
        inputLayer
        numInputs        
    end
    
    methods (Access = 'public')
        function [obj] = EltWiseAdd(name, index, inLayer)
            obj.name = name;
            obj.index = index;
            obj.inputLayer = inLayer;            
            % EltWiseAdd does not change the shape of it's output, and it's
            % input shapes are also the same
            if ~isempty(inLayer)
                obj.activationShape = obj.inputLayer{1}.getActivationShape();
            end
            obj.weightShape = [];
        end
        
        function [additionResult] = ForwardPropagation(obj, input, weights, bias)                        
            tic;
            additionResult = input{1} + input{2};            
            
            % Cache results for backpropagation
            obj.activations = additionResult;
            obj.previousInput1 = input{1};
            obj.previousInput2 = input{2};
            
            % Get execution time
            obj.executionTime = toc;
        end
        
        function [gradient] = BackwardPropagation(obj, dout)
            dout = dout.input;            
            gradient.input1 = dout;
            gradient.input2 = dout;
            
            % Cache gradients
            obj.gradients = gradient;
            
            if obj.doGradientCheck
                evalGrad = obj.EvalBackpropNumerically(dout);
                diff_Input1 = sum(abs(evalGrad.input1(:) - gradient.input1(:)));   
                diff_Input2 = sum(abs(evalGrad.input2(:) - gradient.input2(:)));  
                diff_vec = [diff_Input1 diff_Input2]; 
                diff = sum(diff_vec);
                if diff > 0.0001
                    msgError = sprintf('%s gradient failed!\n',obj.name);
                    error(msgError);
                else
                    %fprintf('%s gradient passed!\n',obj.name);
                end
            end
        end
        
        function gradient = EvalBackpropNumerically(obj, dout)
            % Eltwise connected layers has 2 inputs so we have 2 gradients
            eltwiseadd_x1 = @(x) obj.ForwardPropagation({x, obj.previousInput2},[],[] );            
            eltwiseadd_x2 = @(x) obj.ForwardPropagation({obj.previousInput1, x},[],[] );
            
            % Evaluate
            gradient.input1 = GradientCheck.Eval(eltwiseadd_x1,obj.previousInput1, dout);
            gradient.input2 = GradientCheck.Eval(eltwiseadd_x2,obj.previousInput2, dout);
        end
    end
    
end

