export const StorageConfig = {
    photo: {
        destination: '../storage/photos/',
        urlPrefix: '/assets/photos/',
        maxSize: 3 * 1024 * 1024,
        resize: {
            thumb: {
                width: 120, 
                height: 100,
                directory: 'thumb/'
            },
            small: {
                width: 320, 
                height: 240,
                directory: 'small/'
            },
        },
    },
};
