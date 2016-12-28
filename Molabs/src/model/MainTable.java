package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class MainTable extends JSON_Exportable{
	
	private Hashtable<Date,TextFile> files;
	private ArrayList<String> workingWavelengths;
	
	public MainTable() {
		this.files = new Hashtable<Date,TextFile>();
		this.workingWavelengths = new ArrayList<String>();
	}
	
	/*
	 * Parses and stores the data from a valid textFile containing spectrometer data.
	 */
	public boolean addFile(String path) {
		TextFile txtData = new TextFile(path);
		
		if(txtData.getDate() != null) {
			this.files.put(txtData.getDate(), txtData);
			return true;
		}
		
		return false;
	}
	
	public boolean addWorkingWavelength(String wavelength) {
		if (!this.workingWavelengths.contains(wavelength)) {
			this.workingWavelengths.add(wavelength);
			return true;
		}
		return false;
	}
	
	public boolean removeWorkingWavelength(String wavelength) {
		if(this.workingWavelengths.contains(wavelength)) {
			this.workingWavelengths.remove(wavelength);
			return true;
		}
		return false;
	}
	
	
	public Hashtable<Date,TextFile> getAllFiles() {
		return this.files;
	}
	
	public TextFile getFile(Date dateKey) {
		return this.files.get(dateKey);
	}
	
	public ArrayList<String> getWorkingWaveLengths() {
		return this.workingWavelengths;
	}

}