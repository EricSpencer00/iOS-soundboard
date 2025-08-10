//
//  SettingsView.swift
//  Soundboard
//
//  Created by Eric Spencer on 8/10/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var purchaseService: PurchaseService
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "speaker.wave.3.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Soundboard Pro")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Text("Unlock 200+ premium sounds and remove all limitations!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Premium Features")
                }
                
                Section {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Free Sounds")
                                .font(.headline)
                            Text("45 sounds included")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("✓")
                            .foregroundColor(.green)
                            .font(.title2)
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Premium Sounds")
                                .font(.headline)
                            Text("200+ additional sounds")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if purchaseService.hasPurchasedPremium {
                            Text("✓")
                                .foregroundColor(.green)
                                .font(.title2)
                        } else {
                            Text("$0.99")
                                .foregroundColor(.blue)
                                .font(.headline)
                        }
                    }
                } header: {
                    Text("What's Included")
                }
                
                Section {
                    if !purchaseService.hasPurchasedPremium {
                        Button(action: {
                            purchaseService.purchasePremium()
                        }) {
                            HStack {
                                Spacer()
                                if purchaseService.isLoading {
                                    ProgressView()
                                        .scaleEffect(0.8)
                                        .padding(.trailing, 8)
                                }
                                Text("Upgrade to Pro - $0.99")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                        .disabled(purchaseService.isLoading)
                        
                        Button(action: {
                            purchaseService.restorePurchases()
                        }) {
                            HStack {
                                Spacer()
                                Text("Restore Purchases")
                                    .foregroundColor(.blue)
                                Spacer()
                            }
                        }
                        .disabled(purchaseService.isLoading)
                    } else {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Premium Unlocked")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
                
                Section {
                    Link(destination: URL(string: "https://www.apple.com/legal/privacy/")!) {
                        HStack {
                            Text("Privacy Policy")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                        HStack {
                            Text("Terms of Service")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("About")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView(purchaseService: PurchaseService())
}
