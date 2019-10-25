function [result] = icv_TanD(angle)
    result = icv_SinD(angle) / icv_CosD(angle);
end

