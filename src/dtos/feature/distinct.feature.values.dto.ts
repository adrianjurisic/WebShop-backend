export default class DistinctFeatureValuesDto {
    features: {
        featureId: number;
        name: string;
        values: string[];
    }[];
}