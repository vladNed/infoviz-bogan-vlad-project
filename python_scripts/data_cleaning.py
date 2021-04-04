from typing import Dict, List, Tuple
import pandas as pd
import os


def dataset_import(files: List[str]) -> Tuple[pd.DataFrame]:
    return (
        pd.read_csv(path)
        for path in files
    )


def replace_dollar_sign(value: str) -> float:
    return float(value.replace('$', ''))


def nyc_cleaner(dataset: pd.DataFrame) -> pd.DataFrame:

    # Drop columns that are not relevant to our project such as the
    # name of the housing, the last review and reviews per month
    dataset = dataset.drop(['name','host_name', 'last_review', 'reviews_per_month'], axis=1)

    # Transform data that is categorical to numerical values
    categorical_cols = ['room_type', 'neighbourhood', 'neighbourhood_group']
    for col in categorical_cols:
        dataset[col] = dataset[col].astype('category')
        dataset[f'{col}_cat'] = dataset[col].cat.codes

    return dataset


def boston_cleaner(dataset: pd.DataFrame) -> pd.DataFrame:

    # There are a lot of null values presented in this dataset
    # mostly we don't think we need data bout the host or reviews yet
    dataset = dataset.drop(labels=[
        'city', 'host_location', 'neighbourhood', 'space', 'transit', 'access',
        'interaction', 'weekly_price', 'monthly_price', 'square_feet', 'neighbourhood_group_cleansed'
    ], axis=1)

    # Fill the missing values for beds and bathrooms and bedrooms as at least each
    # house has one
    dataset['property_type'].fillna('Aprtament', inplace=True)
    dataset['beds'].fillna(1.0, inplace=True)
    dataset['bedrooms'].fillna(1.0, inplace=True)
    dataset['bathrooms'].fillna(1.0, inplace=True)
    dataset['review_scores_rating'].fillna(0.0)

    # Cleaning fee should be an interesting column. We transform it from the type "$10.00" to "10.00"
    dataset['cleaning_fee'] = dataset['cleaning_fee'].apply(lambda x: replace_dollar_sign(x) if isinstance(x, str) else x)

    # We meade a mean for this cleaning fee and add it to the null values
    dataset['cleaning_fee'].fillna(68)

    return dataset


def cleansed_dataset_writer(datasets: Dict[str, pd.DataFrame]) -> None:

    if not os.path.isdir('../clean_datasets'):
        try:
            os.mkdir('../clean_datasets')
        except OSError:
            print('Could not create clean dir')
            return

    for path ,df in datasets.items():
        df.to_csv(path, index=True)


if __name__ == '__main__':
    paths = ['../datasets/NYC_AIRBNB.csv', '../datasets/BOSTON_LISTING.csv']
    nyc_df, boston_df = dataset_import(paths)
    nyc_df = nyc_cleaner(nyc_df)
    boston_df = boston_cleaner(boston_df)
    datasets = {
        '../clean_datasets/NYC_CLEAN.csv': nyc_df,
        '../clean_datasets/BOSTON_CLEAN.csv': boston_df
    }
    cleansed_dataset_writer(datasets)
    print('DONE....')