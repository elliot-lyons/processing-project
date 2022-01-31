class covidDataRow
{
  TableRow row;

  private String date;
  private String area;
  private String state;
  private String geoId;
  private int cases;

  covidDataRow(TableRow row)
  {
    this.row = row;

    date = row.getString(0);
    area = row.getString(1);
    state = row.getString(2);
    geoId = row.getString(3);
    cases = row.getInt(4);
  }
}
