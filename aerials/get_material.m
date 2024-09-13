function material = get_material(material_name)
    if strcmpi(material_name, 'copper')
        material = metal('Copper');
    elseif strcmpi(material_name, 'aluminum')
        material = metal('Aluminum');
    else
        error('Unsupported wire type.');
    end
end

