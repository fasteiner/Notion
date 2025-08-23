class notion_formula_database_property_structure
{
    # The formula expression string that defines the calculation
    [string] $expression

    # Default constructor - creates empty formula structure
    notion_formula_database_property_structure()
    {
    }

    # Constructor with expression parameter - creates formula structure with given expression
    notion_formula_database_property_structure([string] $expression)
    {
        $this.expression = $expression
    }

    # Static method to convert from object representation to strongly-typed class
    # Validates input and handles type conversion with error handling
    static [notion_formula_database_property_structure] ConvertFromObject($Value)
    {
        # Validate input - must have expression property
        if (!$Value -or !$Value.expression)
        {
            Write-Error "Value must contain an 'expression' property" -Category InvalidData -TargetObject $Value -RecommendedAction "Provide a valid object with an 'expression' property"
            return $null
        }
        
        # Return existing object if already correct type (optimization)
        if ($Value -is [notion_formula_database_property_structure])
        {
            return $Value
        }
        
        # Create new instance and copy expression property
        $notion_formula_database_property_structure_obj = [notion_formula_database_property_structure]::new()
        $notion_formula_database_property_structure_obj.expression = $Value.expression
        return $notion_formula_database_property_structure_obj
    }
}


class notion_formula_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/page-property-values#formula
{
    # The formula structure containing the expression and related properties
    [notion_formula_database_property_structure] $formula

    # Default constructor - creates formula property with empty expression
    # Calls base constructor with "formula" type
    notion_formula_database_property() : base("formula")
    {
        $this.formula = [notion_formula_database_property_structure]::new()
    }

    # Constructor with expression parameter - creates formula property with given expression
    # Calls base constructor with "formula" type and initializes formula with expression
    notion_formula_database_property([string]$expression) : base("formula")
    {
        $this.formula = [notion_formula_database_property_structure]::new($expression)
    }

    # Static method to convert from object representation to strongly-typed class
    # Handles nested formula structure conversion with comprehensive error handling
    static [notion_formula_database_property] ConvertFromObject($Value)
    {
        # Create default instance to return (ensures we always return valid object)
        $formula_obj = [notion_formula_database_property]::new()
        
        # Validate input - must have formula property
        if (!$Value -or !$Value.formula)
        {
            Write-Error "Value must contain a 'formula' property" -Category InvalidData -TargetObject $Value -RecommendedAction "Provide a valid object with a 'formula' property"
            return $formula_obj
        }
        
        # Return existing object if already correct type (optimization)
        if ($value -is [notion_formula_database_property])
        {
            return $value
        }
        
        # Convert nested formula structure using its ConvertFromObject method
        # This may fail and return null, but we handle it gracefully
        $formula_obj.formula = [notion_formula_database_property_structure]::ConvertFromObject($Value.formula)
        return $formula_obj
    }
}
